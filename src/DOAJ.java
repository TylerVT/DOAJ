import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;

/**
 * Created by tylerbrown on 7/31/14.
 */
public class DOAJ {
    public static void main(String[] args) {
        new DOAJ().run();
    }

    public void run()
    {
        File inputDirectory = new File("input");

        for (File xmlFile : inputDirectory.listFiles())
        {
            System.out.println("Transforming: " + xmlFile.getName());

            Source xmlInput = new StreamSource(xmlFile);
            Source xsl = new StreamSource(new File("resources/DOAJ.xsl"));
            Result xmlOutput = new StreamResult(new File("output/" + xmlFile.getName()));

            try {
                Transformer transformer = TransformerFactory.newInstance().newTransformer(xsl);
                transformer.transform(xmlInput, xmlOutput);
            } catch (TransformerException e) {
                // Handle.
            }
        }
    }
}
