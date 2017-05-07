package com.hjd.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.EquipmentBean;
import com.hjd.base.BaseAction;
import com.hjd.dao.IBusEquBrandDao;
import com.hjd.domain.ViewEquBrand;

@RestController
public class BusEquBrandAction extends BaseAction{
	@Autowired
	IBusEquBrandDao iBusEquBrandDao;
	/**
	 * 根据英文字母查询设备名称首字母相匹配的结果集
	 * @param equipmentBean
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.POST},params={"Action=EquBrandFpy"})
	public Map<String, Object> searchBrandNameFpy(@RequestBody EquipmentBean equipmentBean){
		String [] fpy=equipmentBean.getFpy();
		Map<String,Object> map = new HashMap<String, Object>();
		if(fpy!=null && fpy.length>0)
		{
			for(int i=0;i<fpy.length;i++)
			{
				List<ViewEquBrand> list=iBusEquBrandDao.queryBrandNameByFpy(fpy[i]);
				map.put(fpy[i], list);
			}
		}
		return map;
	}
}
