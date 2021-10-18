package com.teamproject.StudentCommunity.controller;

import com.google.gson.JsonObject;
import com.teamproject.StudentCommunity.utils.UploadFileUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

@RequestMapping("/post/img")
@Controller
@Slf4j
public class PostImgController {


    @RequestMapping(value="/upload", produces = "application/json; charset=utf8")
    @ResponseBody
    public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  throws IOException, Exception{
        JsonObject jsonObject = new JsonObject();


        String uploadPath = request.getSession().getServletContext().getRealPath("/")+"resources";
        log.info(uploadPath);
        String fileRoot = uploadPath + File.separator + "post_image";

        String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
        String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명



        try {
            InputStream fileStream = multipartFile.getInputStream();
            log.info("파일 업로드 성공1 {}",fileStream.toString());

            UploadFileUtils.fileUpload(fileRoot,savedFileName, multipartFile.getBytes());

//            FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
            log.info("파일 업로드 성공2");
            jsonObject.addProperty("url", "/resources/post_image/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
            log.info("/resources/post_image/"+savedFileName);
            jsonObject.addProperty("responseCode", "success");
        } catch (IOException e) {
            log.info("파일 업로드 실패");
            jsonObject.addProperty("responseCode", "error");
            e.printStackTrace();
        }
        String img = jsonObject.toString();
        return img;
    }



}