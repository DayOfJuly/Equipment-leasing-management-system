package com.hjd.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Util {

/**
 * MD5加密
 * @param userName
 * @param password
 */
		private static final String addit = "crec equLease auth";
		public final static String MD5(String userName, String password) { 

		try{
			//	获得MD5摘要算法的 MessageDigest 对象
			MessageDigest md = MessageDigest.getInstance("MD5");
			//	使用指定的字节更新摘要
			md.update((userName + password).getBytes("8859_1"));
			md.update((password + userName).getBytes("8859_1"));
			md.update((addit).getBytes("8859_1"));
			//	获得密文
			byte[] b = md.digest();
			//	把密文转换成十六进制的字符串形式
			return bytesToHexString(b);
			}
		catch(UnsupportedEncodingException e){
			e.printStackTrace();
			}
		catch(NoSuchAlgorithmException e){
			e.printStackTrace();
			}

		return null;
			}

/**
 * 将byte数组转换成16进制 
 */
	public static String bytesToHexString(byte[] b) {

		StringBuilder stringBuilder = new StringBuilder("");
		for(int i=0;i<b.length;i++){
			String hv = Integer.toHexString(b[i] & 0xFF);
        	if(hv.length()<2){
                stringBuilder.append(0);
        		}
        	stringBuilder.append(hv);
        	}

		return stringBuilder.toString();
		}

	public static void main(String[] args) {

		System.out.println(MD5Util.MD5("sh","sh"));
		}

	}
