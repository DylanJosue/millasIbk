import io.cucumber.junit.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(features = "src/test/resources/features",
        glue = "stepsdefinitions",
        tags = {"@Automated", "@CONSULT_NIUBIZ_ECOMMERCE1"}
)
public class CucumberTestSuite {
    
}
