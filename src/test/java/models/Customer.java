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
public class Customer {
    public String documentType;
    public String documentNumber;

}
