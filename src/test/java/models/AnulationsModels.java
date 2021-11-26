package models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author César Ilachoque
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AnulationsModels {
    public String cardId;
    public Commerce commerce;
    public Customer customer;
    public String terminal;
    public String orderNumber;

}
