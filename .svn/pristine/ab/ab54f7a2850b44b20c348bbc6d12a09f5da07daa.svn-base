package com.hjd.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.hjd.base.IFException;

public class Util {

	/**
	 * 将字符串数组转换成特定格式的字符串
	 * @param strArray
	 * @return
	 */
	public static String arrayToString(String[] strArray) {

		if(strArray==null || strArray.length==0)
		{
			return "";
		}
		else
		{
			if(strArray.length==1)
			{
				return "'"+strArray[0].toString()+"'";
			}
			else
			{
				StringBuffer arrayStr = new StringBuffer();
				arrayStr.append("'"+strArray[0].toString()+"'");
				for(int i=1;i<strArray.length;i++)
				{
					arrayStr.append(",'"+strArray[i].toString()+"'");
				}
				return arrayStr.toString();
			}
		}
	}
	
	/**
	 * 将整数数组转换成特定格式的字符串
	 * @param strArray
	 * @return
	 */
	public static String arrayToString(Integer[] strArray) {

		if(strArray==null || strArray.length==0)
		{
			return "";
		}
		else
		{
			if(strArray.length==1)
			{
				return toStringAndTrim(strArray[0]).toString();
			}
			else
			{
				StringBuffer arrayStr = new StringBuffer();
				arrayStr.append(toStringAndTrim(strArray[0]).toString());
				for(int i=1;i<strArray.length;i++)
				{
					if(isNotNullOrEmpty(strArray[i]))
					{
						arrayStr.append(" ,"+toStringAndTrim(strArray[i]).toString());
					}
					
				}
				return arrayStr.toString();
			}
		}
	}
	
	/**
	 * 将对象转换为字符串并且去掉前后的空格
	 * @param object
	 * @return
	 */
	public static String toStringAndTrim(Object object) {

		if(object==null)
			return "";
		else
			return object.toString().trim();
	}
	
	/**
	 * 判断对象是否为空
	 * @param object
	 * @return
	 */
	public static boolean isNullOrEmpty(Object object){
		if(object==null||"".equals(object.toString()))
			return true;
		return false;
	}
	/**
	 * 判断对象是否不为空
	 * @author Qian
	 * @param object
	 * @return 
	 */
	public static boolean isNotNullOrEmpty(Object object)
	{
		if(object==null)
		{
			return false;
	    }
		else if("".equals(object.toString().trim()))
		{
	    	return false;
	    }
		else if(object.getClass().isArray() && ((Object[])(object)).length==0)
		{
	    	return false;
	    }
		else
		{
			return true;
		}
	 }
	/**
	 * 判断对象中是否含有非法字符，暂时未实现
	 * @param object
	 * @return
	 */
	public static boolean isValueSuccessed(Object object)
	{
		if(object==null)
		{
			return false;
	    }
		else if("".equals(object.toString().trim()))
		{
	    	return false;
	    }
		else
		{
			return true;
		}
	 }
	/**
	 * 将图片从临时目录移动到真实目录，并删除临时路径图片
	 * @param tmpInfoFilePath 临时图片存放路径
	 * @param realInfofilePath 真实图片存放路径
	 * @param fileNames 移动图片的名称数组 例如 [a.png,b.jpb,c.png]
	 */
	public static void copyFileToRealPath(String tmpInfoFilePath,String realInfofilePath,String[] fileNames){
		File file = null;
		FileInputStream fis = null;
		BufferedInputStream bis = null;
		FileOutputStream fos = null;
		for(String fileName : fileNames){
			try{
				file = new File(tmpInfoFilePath+"/"+fileName);
				if(!file.exists()){
					continue;
				}
				fis = new FileInputStream(file);
				bis=new BufferedInputStream(fis);
				File fileUploadPath = new File(realInfofilePath);
				if(!fileUploadPath.exists()){fileUploadPath.mkdirs();}
				fos = new FileOutputStream(realInfofilePath+File.separator+fileName);//写入文件
				byte data[]=new byte[4096];
		        int size=0;
		        size=bis.read(data);   
		        while (size!=-1){      
		        	fos.write(data,0,size);           
		            size=bis.read(data);
		        }
		        fos.flush();
			}catch(IOException e){
				e.printStackTrace();
				throw new IFException("500","将图片从临时路径拷贝到真实路径出错...");
			}finally{
				try{
					if(fis != null)
						fis.close();
					if(bis != null)
						bis.close();
					if(fos != null)
						fos.close();
					if(file.exists())
						file.delete();//删除临时路径图片
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
		}
	}
	
	/**
	 * The date is converted into a string
	 * @param date :to be converted to a string date(java.util.Date)
	 * @param pattern :the conversion date format
	 */
	public static final String convertDateToStr(java.util.Date date,String pattern) {
		String dateStr = "";
		if("".equals(date))
			return dateStr;
		SimpleDateFormat formatter = new SimpleDateFormat(pattern);
		try{
			dateStr = formatter.format(date);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return dateStr;
	}

}
