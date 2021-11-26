package models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author César Ilachoque
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ExchangeModel {
    public Integer totalMiles;
    public Integer totalAmount;
    public String currencyId;
    public Integer netMiles;
    public Double netAmount;
    public List<Items> items;
    public Commerce commerce;
    public Customer customer;
    public String terminal;
    public String orderNumber;

}
