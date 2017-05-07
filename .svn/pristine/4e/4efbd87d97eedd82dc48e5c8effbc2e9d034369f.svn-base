package com.hjd.util.pinyin;


public class PinyinUtil {
	
	/**
	 * 获取中文字符串的，大写拼音首字母组合字符串，如果没有拼音字符，则返回元字符串
	 * @param chineseStr
	 * @return
	 */
	public static String getUpperCaseShortPinyin(String chineseStr)
	{
		return PinyinHelper.getShortPinyin(chineseStr).toUpperCase();
	}
	
	/**
	 * 获取中文字符串的首字的，大写拼音首字母，如果没有拼音字符，就返回元字符串
	 * @param chineseStr
	 * @return
	 */
	public static String getUpperCaseFirstPinyin(String chineseStr)
	{
		String pinyinStr=PinyinHelper.getShortPinyin(chineseStr).toUpperCase();
		char pinyinChar[]=pinyinStr.toCharArray();
		for(int i=0;i<pinyinChar.length;i++)
		{
			if(Character.isUpperCase(pinyinChar[i]))
			{
				return Character.toString(pinyinChar[i]);
			}
		}
		return pinyinStr;
	}

}
