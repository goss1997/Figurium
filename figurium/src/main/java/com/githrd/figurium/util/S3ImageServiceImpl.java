package com.githrd.figurium.util;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.util.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.*;

@Service
@PropertySource("classpath:/s3.properties")
public class S3ImageServiceImpl implements S3ImageService{

    // 저장할 버킷의 폴더
    private static final String BASE_DIR = "images/";

    private final AmazonS3 amazonS3;

    @Value("${cloud.aws.s3.bucket}")
    private String bucketName;

    @Autowired
    public S3ImageServiceImpl(AmazonS3 amazonS3) {
        System.out.println("-- S3ImageService --");
        this.amazonS3 = amazonS3;
    }

    // S3에 업로드.
    @Override
    public String uploadS3(MultipartFile image) {
        // 가져온 이미지 파일이 빈 파일인지 검증하기.
        if (image.isEmpty() || Objects.isNull(image.getOriginalFilename())) {
            System.out.println("파일이 없습니다.");
        }
        // uploadImage를 호출하여 S3에 저장된 이미지의 public url을 반환한다.
        return this.uploadImage(image);
    }

    // S3에 다중 업로드.
    public List<String> uploadS3(List<MultipartFile> images) {

        List<String> imgUrlList = new ArrayList<>(); // imageUrls

        // 리스트가 비어있는지 검증하기.
        if (images.isEmpty()) {
            System.out.println("업로드할 파일이 없습니다.");
        }

        // 반복문을 통해 업로드 하기.
        for (MultipartFile multipartFile : images) {
            String fileUrl = uploadS3(multipartFile);

            imgUrlList.add(fileUrl);
        }

        return imgUrlList;
    }


    // S3에 이미지 업로드.
    private String uploadImage(MultipartFile image) {
        // 확장자명이 올바른지 확인하기.
        this.validateImageFileExtention(image.getOriginalFilename());
        try {
            // 해당 이미지를 S3에 업로드하고 S3에 저장된 이미지의 public url을 반환하기.
            return this.uploadImageToS3(image);
        } catch (IOException e) {
            System.out.println("가져올 수 없는 이미지입니다.");
        }
        return "";
    }

    // 파일의 확장자 검증(jpg, jpeg, png, gif)
    private void validateImageFileExtention(String filename) {
        int lastDotIndex = filename.lastIndexOf(".");
        if (lastDotIndex == -1) {
            System.out.println("유효하지 않은 파일 확장자입니다.");
        }

        // 파일의 확장자만 추출.
        String extention = filename.substring(lastDotIndex + 1).toLowerCase();
        List<String> allowedExtentionList = Arrays.asList("jpg", "jpeg", "png", "gif");

        // jpg, jpeg, png, gif 인지 검증.
        if (!allowedExtentionList.contains(extention)) {
            System.out.println("수용할 수 없는 확장자입니다.");
        }
    }

    // 직접적으로 S3에 업로드.
    private String uploadImageToS3(MultipartFile image) throws IOException {
        String originalFilename = image.getOriginalFilename(); //원본 파일 명
        String extention = originalFilename.substring(originalFilename.lastIndexOf(".")); //확장자 명

        String s3FileName = UUID.randomUUID().toString().substring(0, 10) + originalFilename; //변경된 파일 명

        // s3FileName에 image directory 경로 추가.
        s3FileName = BASE_DIR + s3FileName;

        InputStream is = image.getInputStream();
        byte[] bytes = IOUtils.toByteArray(is); // image를 byte[]로 변환

        ObjectMetadata metadata = new ObjectMetadata(); // metadata 생성
        metadata.setContentType("image/" + extention);
        metadata.setContentLength(bytes.length);

        // S3에 요청할 때 사용할 byteInputStream 생성
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);

        try {
            // S3로 putObject 할 때 사용할 요청 객체
            // 생성자 : bucket 이름, 파일명, byteInputStream, metadata
            PutObjectRequest putObjectRequest =
                    new PutObjectRequest(bucketName, s3FileName, byteArrayInputStream, metadata)
                            .withCannedAcl(CannedAccessControlList.PublicRead);

            // S3에 이미지 데이터 추가.
            amazonS3.putObject(putObjectRequest); // put image to S3
        } catch (Exception e) {
            System.out.println("요청 객체로 S3에 업로드 실패하였습니다.");
        } finally {
            byteArrayInputStream.close();
            is.close();
        }

        return amazonS3.getUrl(bucketName, s3FileName).toString();
    }

    // S3에 이미지 삭제하기.
    public void deleteImageFromS3(String imageUrl) {
        String key = getKeyFromimageUrl(imageUrl);
        try {
            amazonS3.deleteObject(new DeleteObjectRequest(bucketName, key));
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("S3에 이미지 삭제에 실패하였습니다.");
        }
    }

    // S3에 삭제 요청 시 필요한 key 생성.
    private String getKeyFromimageUrl(String imageUrl) {
        try {
            URL url = new URL(imageUrl);
            String decodingKey = URLDecoder.decode(url.getPath(), "UTF-8");
            return decodingKey.substring(1); // 맨 앞의 '/' 제거
        } catch (MalformedURLException | UnsupportedEncodingException e) {
            System.out.println("삭제 시 key 디코딩에 실패하였습니다.");
        }
        return "";
    }


}
