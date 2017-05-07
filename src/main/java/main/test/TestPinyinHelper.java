package main.test;

import org.junit.Assert;
import org.junit.Test;

import com.hjd.util.pinyin.PinyinFormat;
import com.hjd.util.pinyin.PinyinHelper;
import com.hjd.util.pinyin.PinyinUtil;

public class TestPinyinHelper {

    @Test
    public void testConvertToPinyinArray() {
        Assert.assertArrayEquals(PinyinHelper.convertToPinyinArray('为'), new String[] { "wèi", "wéi" });
        Assert.assertArrayEquals(PinyinHelper.convertToPinyinArray('为', PinyinFormat.WITH_TONE_MARK), new String[] { "wèi", "wéi" });
        Assert.assertArrayEquals(PinyinHelper.convertToPinyinArray('为', PinyinFormat.WITH_TONE_NUMBER), new String[] { "wei4", "wei2" });
        Assert.assertArrayEquals(PinyinHelper.convertToPinyinArray('为', PinyinFormat.WITHOUT_TONE), new String[] { "wei" });

        Assert.assertArrayEquals(PinyinHelper.convertToPinyinArray('一'), new String[] { "yī" });
        Assert.assertArrayEquals(PinyinHelper.convertToPinyinArray('一', PinyinFormat.WITH_TONE_MARK), new String[] { "yī" });
        Assert.assertArrayEquals(PinyinHelper.convertToPinyinArray('一', PinyinFormat.WITH_TONE_NUMBER), new String[] { "yi1" });
        Assert.assertArrayEquals(PinyinHelper.convertToPinyinArray('一', PinyinFormat.WITHOUT_TONE), new String[] { "yi" });
    }

    @Test
    public void testConvertToPinyinString() {
        Assert.assertEquals(PinyinHelper.convertToPinyinString("你好世界", ","), "nǐ,hǎo,shì,jiè");
        Assert.assertEquals(PinyinHelper.convertToPinyinString("你好世界", ",", PinyinFormat.WITH_TONE_MARK), "nǐ,hǎo,shì,jiè");
        Assert.assertEquals(PinyinHelper.convertToPinyinString("你好世界", ",", PinyinFormat.WITH_TONE_NUMBER), "ni3,hao3,shi4,jie4");
        Assert.assertEquals(PinyinHelper.convertToPinyinString("你好世界", ",", PinyinFormat.WITHOUT_TONE), "ni,hao,shi,jie");
    }

    @Test
    public void testHasMultiPinyin() {
        Assert.assertTrue(PinyinHelper.hasMultiPinyin('好'));
        Assert.assertTrue(!PinyinHelper.hasMultiPinyin('一'));

        Assert.assertTrue(!PinyinHelper.hasMultiPinyin('爱'));
        Assert.assertTrue(PinyinHelper.hasMultiPinyin('为'));
    }

    @Test
    public void testGetShortPinyin() {
        Assert.assertEquals(PinyinHelper.getShortPinyin("你好世界"), "nhsj");
    }
    
    /**
     * @author Q
     */
    @Test
    public void testGetPinyin() {
    	printConvertInfo("这款软件真的很棒");
    	printConvertInfo("风萧萧兮易水寒壮士一去兮不复还");
    	printConvertInfo("重");
    	printConvertInfo("重庆");
    	printConvertInfo("和");
    	printConvertInfo("tiantian和你");
    	printConvertInfo("我tiantian你");
    	printConvertInfo("我和tian");
    	printConvertInfo("#$%【和】你");
    	printConvertInfo("我123你");
    	printConvertInfo("123和tian");
    	printConvertInfo("123　");
    	printConvertInfo("　");
    	printConvertInfo("{}＄％＾＊");
    }
    /**
     * 打印汉语字符串转换成汉语拼音的信息
     * @param chineseStr
     */
    private void printConvertInfo(String chineseStr)
    {
//    	System.err.println("汉字 【 "+chineseStr+" 】对应的拼音是："+PinyinHelper.getShortPinyin(chineseStr)+"\n\n");
//    	System.err.println("汉字 【 "+chineseStr+" 】对应的拼音是："+PinyinHelper.convertToPinyinString(chineseStr, ",", PinyinFormat.WITHOUT_TONE)+"\n\n");
    	
    	System.err.println("汉字 【 "+chineseStr+" 】对应的拼音是："+PinyinUtil.getUpperCaseShortPinyin(chineseStr)+"\n\n");
    	System.err.println("汉字 【 "+chineseStr+" 】对应的拼音是："+PinyinUtil.getUpperCaseFirstPinyin(chineseStr)+"\n\n");
    	
    }
}
