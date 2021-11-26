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
public class Commerce {
    public String code;
    public String name;
    
}
