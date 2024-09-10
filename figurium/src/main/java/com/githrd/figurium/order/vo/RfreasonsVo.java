package com.githrd.figurium.order.vo;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data           // Getter + Setter
@Alias("rfreasons")
public class Rfreasons {

    String name;
    int orderId;
}
