package com.hjd.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hjd.base.IFException;

@RestController
public class PictureAction{
	
	@Value("${tmpInfoFilePath}")
	String tmpInfoFilePath="";
	
	@Value("${realInfofilePath}")
	String realInfofilePath="";

	/**
	 * 上传文件
	 * return 服务器端生成的真实的文件名
	 */
	@RequestMapping(value="/Picture",method={RequestMethod.POST})
	public Map<String,String> upload(MultipartHttpServletRequest request) {

		Map<String,String> resultMap = new HashMap<String,String>();

		File fileUploadPath = new File(tmpInfoFilePath);
		if(!fileUploadPath.exists())
			fileUploadPath.mkdirs();

		List<MultipartFile> files = request.getFiles("file");
		if(files==null || files.size()<=0 || files.get(0).isEmpty())
			return resultMap;

		String originalFileName = files.get(0).getOriginalFilename();
		UUID uuid = UUID.randomUUID();
		String realFileName = uuid + originalFileName.substring(originalFileName.lastIndexOf("."));

		FileOutputStream fos = null;
		try{
			byte[] bytes = files.get(0).getBytes();
			fos = new FileOutputStream(tmpInfoFilePath + File.separator + realFileName);//写入文件
			fos.write(bytes);
			}
		catch(IOException e){
			e.printStackTrace();
			throw new IFException("读取文件出错！");
			}
		finally{
			try{
				if(fos!=null)
					fos.close();
				}
			catch(IOException e){
				e.printStackTrace();
				}
			}

		resultMap.put("fileName", realFileName);

		return resultMap;
		}

	/**
	 * 下载临时文件图片
     * 根据imgUri获得图片并输出到response
     */
	@RequestMapping(value="/Picture/{fileName}/{fileSuffix}",method={RequestMethod.GET},params={"Action=TmpPic"})
	public void outTmpPutImage(HttpServletRequest request, HttpServletResponse response, @PathVariable String fileName, @PathVariable String fileSuffix) {

		downloadImg(response, fileName, fileSuffix, tmpInfoFilePath);
		}

	/**
	 * 下载图片
     * 根据imgUri获得图片并输出到response
     */
	@RequestMapping(value="/Picture/{fileName}/{fileSuffix}",method={RequestMethod.GET})
	public void outPutImage(HttpServletRequest request, HttpServletResponse response, @PathVariable String fileName, @PathVariable String fileSuffix) {

		downloadImg(response, fileName, fileSuffix, realInfofilePath);
		}

	private void downloadImg(HttpServletResponse response, String fileName, String fileSuffix, String infofilePath) {

		response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

		String filePath = infofilePath + "/" + fileName + "." + fileSuffix;
		FileInputStream imageIn = null;
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try{
			imageIn = new FileInputStream(filePath);
			bis = new BufferedInputStream(imageIn);
			bos = new BufferedOutputStream(response.getOutputStream());

			byte data[] = new byte[4096];
			int size = bis.read(data);
			while(size!=-1){
				bos.write(data,0,size);           
				size = bis.read(data);   
				}
			}
		catch(IOException e){
			e.printStackTrace();
			throw new IFException("下载文件出错！");
			}
		finally{
			try{
				if(imageIn!=null)
					imageIn.close();
				if(bos!=null)
					bos.flush();
				if(bos!=null)
					bos.close();
				}
			catch(IOException e){
				e.printStackTrace();
				}
			}
		}

	}
