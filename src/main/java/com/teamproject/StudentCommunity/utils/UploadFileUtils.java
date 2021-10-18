package com.teamproject.StudentCommunity.utils;

import java.io.File;

import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {

	public static String fileUpload(String uploadPath, String fileName, byte[] fileData) throws Exception {

		File target = new File(uploadPath, fileName);
		FileCopyUtils.copy(fileData, target);

		File image = new File(uploadPath + File.separator + fileName);

		return fileName;
	}

	private static void makeDir(String uploadPath, String... paths) {

		if (new File(paths[paths.length - 1]).exists()) {
			return;
		}

		for (String path : paths) {
			File dirPath = new File(uploadPath + path);

			if (!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
}