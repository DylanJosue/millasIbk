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
public class Items {
    public String identifier;
    public String description;
    public Integer quantity;
    public Double amount;
    public String currencyId;

}
