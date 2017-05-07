package com.hjd.util;

import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.hjd.base.SpringContextBean;
import com.hjd.base.UserManagerBean;
import com.hjd.domain.SysLoginUser;

public class UserQuartzJob extends QuartzJobBean {
	
	/**
	 * 日志
	 */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass()); 

	private UserManagerBean userManagerBean=(UserManagerBean) SpringContextBean.getBean("userManager");
	private Long logoutTime = 3600000L;// 1小时 3600000毫秒


	public UserManagerBean getUserManagerBean() {
		return userManagerBean;
	}

	public void setUserManagerBean(UserManagerBean userManagerBean) {
		this.userManagerBean = userManagerBean;
	}

	@Override
	protected void executeInternal(JobExecutionContext arg0)
			throws JobExecutionException {
		// TODO Auto-generated method stub
logger.debug("任务二被启用.....");
		logoutUser();

	}

	// 系统自动登出用户
	private void logoutUser() {
logger.debug("系统自动清除超时用户开始...");
		int num = 0;
		Map<String, SysLoginUser> map = userManagerBean.getUserMap();
		Iterator<Entry<String, SysLoginUser>> i = map.entrySet().iterator();
		Entry<String, SysLoginUser> entry;
		Long currentTime = System.currentTimeMillis();// 获取系统当前时间
		Long l;
		while (i.hasNext()) {
			entry = i.next();
			SysLoginUser slu = (SysLoginUser) entry.getValue();
			Long heartTime = slu.getCurrentTime().getTime();// 获取用户心跳时间
			if(heartTime==null){
				//如果没有心跳数，那么说明该用户没有登录，直接登录
				//map.put(lub.getLoginName(), lub);//登录成功
			}else{
			l = currentTime - heartTime;// 系统当前时间 - 用户心跳时间
			// 如果大于1小时（3600000毫秒）那么登出用户
				if (l > logoutTime) {
					map.remove(entry.getKey());
					num++;
				}
			}
		}
		Long currentTime2 = System.currentTimeMillis();// 获取系统当前时间
		Long useTime = currentTime2 - currentTime;
logger.debug("共清理超时用户" + num + "个，耗时：" + useTime + "毫秒");
logger.debug("系统自动清除超时用户结束...");
	}

}
