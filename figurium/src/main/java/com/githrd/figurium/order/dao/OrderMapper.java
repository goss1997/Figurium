package com.githrd.figurium.order.dao;

import com.githrd.figurium.order.vo.MyOrderVo;
import com.githrd.figurium.order.vo.Orders;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface OrderMapper {

    int insertOrders(Map<String, Object> map);
    Orders selectOneLast();

    // 사용자 주문 내역 조회
    List<MyOrderVo> selectListByUserId(int userId);

    // 사용자 주문 상세 내역 조회
    List<MyOrderVo> selectListByDetailOrder(int myOrderId, int userId);

    // 사용자 주문 상세 내역 정보 조회
    MyOrderVo selectOneOrderInfo(int myOrderId, int userId);

    // 관리자용 고객무관 전체조회
    List<MyOrderVo> viewAllList();

    // 관리자용 결제취소 전체조회
    List<MyOrderVo> selectListByPayment();

    // 환불처리 주문번호 조회
    MyOrderVo selectOneByMerchantUid(int id);

    // 배송상태 변경시 사용되는 1건 선택
    List<MyOrderVo> selectOneById(int id);

    // 환불처리 성공 후 주문 상태 n으로 변경
    int updateByRefund(int id);

    void updateOrderStatus(int id, String status);

    // 가격 검증 로직 확인용 데이터
    int selectOneByProductsId(int userId);

    int insertRfreasons(String name, int orderId );
}