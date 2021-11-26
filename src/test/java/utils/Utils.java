package utils;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

/**
 * @author César Ilachoque
 */

public class Utils {

    public Properties properties() throws IOException {

        Properties prop = null;
        try {
            prop = new Properties();
            String propFileName = "serenity.properties";

            prop.load(new FileReader(propFileName));

        } catch (Exception e) {
            System.out.println("Exception: " + e);
        }

        return prop;
    }

    public JsonObject getJsonFile(String file) throws IOException {
        JsonObject jsonObject = null;
        JsonParser jsonParser = new JsonParser();

        try {
            Object obj = jsonParser.parse(new FileReader(System.getProperty("user.dir") + "/src/test/resources/data/" + file));
            jsonObject = (JsonObject) obj;
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return jsonObject;
    }

}
