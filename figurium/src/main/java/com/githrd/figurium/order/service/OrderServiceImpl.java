package com.githrd.figurium.order.service;

import com.githrd.figurium.order.dao.CustomersMapper;
import com.githrd.figurium.order.dao.OrderItemsMapper;
import com.githrd.figurium.order.dao.OrderMapper;
import com.githrd.figurium.order.dao.ShippingAddressesMapper;
import com.githrd.figurium.order.vo.MyOrderVo;
import com.githrd.figurium.product.dao.CartsMapper;
import com.githrd.figurium.product.dao.ProductsMapper;
import com.githrd.figurium.product.vo.CartsVo;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    private final ProductsMapper productsMapper;
    private CartsMapper cartsMapper;
    private OrderMapper orderMapper;
    private CustomersMapper customersMapper;
    private ShippingAddressesMapper shippingAddressesMapper;
    private OrderItemsMapper orderItemsMapper;
    private HttpSession session;

    @Autowired
    public OrderServiceImpl(CartsMapper cartsMapper, OrderMapper orderMapper,
                           CustomersMapper customersMapper, ShippingAddressesMapper shippingAddressesMapper,
                           OrderItemsMapper orderItemsMapper, HttpSession session, ProductsMapper productsMapper) {
        this.cartsMapper = cartsMapper;
        this.orderMapper = orderMapper;
        this.customersMapper = customersMapper;
        this.shippingAddressesMapper = shippingAddressesMapper;
        this.orderItemsMapper = orderItemsMapper;
        this.session = session;
        this.productsMapper = productsMapper;
    }


    // 주문창 가져오기
    @Override
    public List<CartsVo> updateCartQuantities(int loginUserId, List<Integer> quantities) {

        // 카드에 담겨있는 상품 가져오기
        List<CartsVo> cartsList = cartsMapper.selectList(loginUserId);


        // 기존 수량 체크
        for (int i = 0; i < cartsList.size(); i++) {

            CartsVo cartsVo = cartsList.get(i);
            int existingQuantity = cartsVo.getQuantity();
            int newQuantity = quantities.get(i);

            if (existingQuantity != newQuantity) {
                cartsVo.setQuantity(newQuantity); // 새로운 수량으로 업데이트
                // 수량을 가져와서 수량이 변경되었다면, 변경된 수량 반영
                int res = cartsMapper.updateCartQuantity(cartsVo);
            }
        }

        return cartsList;
    }


    public int calculateTotalPrice(List<CartsVo> cartsList) {
        // JSP에서 계산 이뤄지게 하는 방식은 권장되지 않아서 서버딴에서 결제 처리
        int totalPrice = 0;

        for(CartsVo products:cartsList) {
            totalPrice += products.getPrice() * products.getQuantity();
        }

        return totalPrice;
    }

    /**
     * 사용자 주문 내역 조회
     */
    @Override
    @Transactional
    public List<MyOrderVo> selectListByUserId(int userId) {
        return orderMapper.selectListByUserId(userId);
    }


}
