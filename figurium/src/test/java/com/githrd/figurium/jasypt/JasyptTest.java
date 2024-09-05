package com.githrd.figurium.jasypt;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;


@SpringBootTest
class JasyptTest {

    @Test
    void jasypt() {
        String secret = "안녕하세요";

        System.out.println("암호화 대상 : " + secret);
        System.out.println("암호화 결과 : " + jasyptEncoding(secret));
    }

    public String jasyptEncoding(String value) {
        String key = "key";
        StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
        pbeEnc.setAlgorithm("PBEWithMD5AndDES");
        pbeEnc.setPassword(key);
        return pbeEnc.encrypt(value);
    }

}

