import burp.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

public class ConvertSHA256 implements IBurpExtender, IIntruderPayloadGeneratorFactory, IIntruderPayloadGenerator {
    private IExtensionHelpers helpers;
    private int payloadIndex;
    private List<String> passwordList;

    @Override
    public void registerExtenderCallbacks(IBurpExtenderCallbacks callbacks) {
        callbacks.setExtensionName("ConvertSHA256");
        helpers = callbacks.getHelpers();
        callbacks.registerIntruderPayloadGeneratorFactory(this);
    }

    @Override
    public boolean hasMorePayloads() {
        return payloadIndex < passwordList.size();
    }

    @Override
    public byte[] getNextPayload(byte[] baseValue) {
        String password = passwordList.get(payloadIndex);
        payloadIndex++;
        return hashSHA256(password);
    }

   
    @Override
    public String getGeneratorName() {
        return "SHA-256 Hash";
    }

    @Override
    public IIntruderPayloadGenerator createNewInstance(IIntruderAttack attack) {
        passwordList = getPasswordListFromFile("/home/kali/Desktop/ToolCla/vario/password2.txt");
        return this;
    }
    
    
    private List<String> getPasswordListFromFile(String filePath) {
        List<String> passwords = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                passwords.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return passwords;
    }

      @Override
        public void reset() {
            payloadIndex = 0;
        }
  
    private byte[] hashSHA256(String input) {
        try {
            System.out.println("INPUT: " +  input);
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(input.getBytes());
            String hash = new String(hashBytes, StandardCharsets.UTF_8);
            System.out.println("HASH: " +  hash);
            return hashBytes;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
