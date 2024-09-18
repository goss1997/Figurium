package com.githrd.figurium.exception.customException;

public class FailToUploadByS3Exception  extends RuntimeException {
    public FailToUploadByS3Exception() {
        super("S3 파일 업로드에 실패하였습니다.");
    }

    public FailToUploadByS3Exception(String message) {
        super(message);
    }
}