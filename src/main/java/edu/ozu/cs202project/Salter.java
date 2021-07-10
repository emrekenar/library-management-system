package edu.ozu.cs202project;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Base64;

public class Salter {
    public static void main(String[] args)
    {
        System.out.println(">: " + salt("d12345", "Group13x"));
        System.out.println(">: " + salt("98765", "Group13x"));
        System.out.println(">: " + salt("111222", "Group13x"));
        System.out.println(">: " + salt("123459", "Group13x"));
        System.out.println(">: " + salt("234567", "Group13x"));
        System.out.println(">: " + salt("can1987", "Group13x"));
        System.out.println(">: " + salt("isbank1937", "Group13x"));
        System.out.println(">: " + salt("12345yapi", "Group13x"));
        System.out.println(">: " + salt("ilet123", "Group13x"));
    }

    public static String salt(String A, String B)
    {
        byte[] hash = new byte[0];

        try {
            KeySpec spec = new PBEKeySpec(
                    A.toCharArray(),
                    B.getBytes(StandardCharsets.UTF_8),
                    65536,
                    128
            );
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");

            hash = factory.generateSecret(spec).getEncoded();
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            e.printStackTrace();
        }

        return Base64.getEncoder().encodeToString(hash);

//        String hashStr = null;
//        try {
//            MessageDigest md = MessageDigest.getInstance("SHA-1");
//            md.update(A.getBytes());
//            BigInteger hash = new BigInteger(1, md.digest());
//            hashStr = hash.toString(16);
//        } catch (NoSuchAlgorithmException e) {
//            e.printStackTrace();
//        }
//
//        return hashStr;
    }
}
