package com.hjd.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hjd.action.bean.FunSetSearchBean;
import com.hjd.action.bean.SysRoleBean;
import com.hjd.action.bean.SysRoleSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.ISysRoleDao;
import com.hjd.dao.ISysRoleFunDao;
import com.hjd.domain.Party;
import com.hjd.domain.ProdFunSet;
import com.hjd.domain.SysLoginRoleType;
import com.hjd.domain.SysRoleFun;
import com.hjd.domain.UploadFileInfo;
import com.hjd.util.Util;

@RestController
public class SystemAction extends BaseAction {

	@Value("${tmpInfoFilePath}")
	private String tmpInfoFilePath;

	@Autowired
	private ISysRoleFunDao sysRoleFunDao;
	@Autowired
	private ISysRoleDao iSysRoleDao;
	
	/**
	 * 角色信息 - 列表查询
	 */
	@RequestMapping(value="/Sys/Role", method={RequestMethod.POST})
	public Page<?> searchSysRole(@RequestBody SysRoleSearchBean sysRoleSearchBean) {

		Long deptId = sysRoleSearchBean.getDeptId();
		if(deptId==null)
			throw new IFException("机构标识不能为空");

		Map<String,Object> params = new HashMap<String,Object>();

		StringBuffer listSql = new StringBuffer();

		listSql.append("select new Map(sysRole.role as roleId,sysRole.name as name,date_format(sysRole.updateTime,'%Y-%m-%d %H:%i:%S') as updateTime,sysRole.party.partyId as deptId,");
		listSql.append("(select org.name from PartyOrg org where org.partyId=sysRole.party.partyId) as deptName) ");
		listSql.append("from SysLoginRoleType sysRole ");
		listSql.append("where sysRole.state=0 and sysRole.party.partyId=").append(deptId);

		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(1) ");
		countSql.append("from SysLoginRoleType sysRole ");
		countSql.append("where sysRole.state=0 and sysRole.party.partyId=").append(deptId);

		listSql.append(" ORDER BY sysRole.updateTime DESC ");
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),params,sysRoleSearchBean.getPageRequest());

		return datas;
		}

	/**
	 * 角色信息 - 详细查询
	 */
	@RequestMapping(value="/Sys/Role/{roleId}", method={RequestMethod.GET})
	public Map<String,Object> searchSysRoleDetail(@PathVariable Long roleId) {

		Map<String,Object> data = new HashMap<String,Object>();

		//	查询角色信息
		SysLoginRoleType role = queryOne(new SysLoginRoleType(roleId));
		if(role==null)
			throw new IFException("没有此角色");

		data.put("roleId",role.getRole());
		data.put("name",role.getName());
		data.put("deptId",role.getParty().getPartyId());
		data.put("parTypeId",role.getParty().getParType().getParTypeId());
		data.put("note",role.getNote());

		//	查询角色与功能信息
		List<SysRoleFun> funRole = sysRoleFunDao.findByRole(role);
		if(funRole==null || funRole.size()<=0)
			return data;

		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> map;
		ProdFunSet function;
		for(SysRoleFun roleFun : funRole){
			map = new HashMap<String,Object>();

			function = roleFun.getFunction();

			map.put("functionId",function.getFunctionId());
			map.put("name",function.getName());
			map.put("note",function.getNote());

			list.add(map);
			}

		data.put("funcInfo",list);

		return data;
		}
	/**
	 * 添加角色时，判断角色名称是否已经存在
	 */
	@RequestMapping(value="/Sys/Role",method={RequestMethod.GET},params={"Action=CheckExistAdd"})
	public Map<String, String> roleNameIsExist(@RequestParam Map<?, ?> reqParamsMap)
	{
		String isExist="FALSE";
		//声明功能变量
		String name=(String)reqParamsMap.get("name");
		SysLoginRoleType role = iSysRoleDao.queryByName(name);
		if(role!=null)
		{
			isExist="TRUE";
	    }
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", isExist);
		return map;
	}
	/**
	 * 角色信息 - 添加
	 */
	@Transactional
	@RequestMapping(value="/Sys/Role", method={RequestMethod.PUT})
	public Long addSysRole(@RequestBody SysRoleBean sysRoleBean) {
		String name = sysRoleBean.getName();
		if("".equals(Util.toStringAndTrim(name)))
			throw new IFException("名称不能为空");

		Long deptId = sysRoleBean.getDeptId();
		if(deptId==null)
			throw new IFException("企业或部门不能为空");

		//	1-添加角色
		SysLoginRoleType role = new SysLoginRoleType();

		role.setName(name);
		role.setNote(sysRoleBean.getNote());
		role.setParty(new Party(deptId));
		role.setState(0);	//	0-启用
		role.setUpdateTime(new Date());

		insert(role);

		Long roleId = role.getRole();

		//	2-添加角色与功能关系
		List<Long> function = sysRoleBean.getFuncInfo();
		if(function==null || function.size()<=0)
			return roleId;

		for(Long functionId : function){
			SysRoleFun roleFun = new SysRoleFun();

			roleFun.setFunction(new ProdFunSet(functionId));
			roleFun.setRole(role);

			insert(roleFun);
			}

		return roleId;
		}
	/**
	 * 修改角色时，判断角色名称是否已经存在，注意是除自身以外的角色名称
	 */
	@RequestMapping(value="/Sys/Role",method={RequestMethod.GET},params={"Action=CheckUniqueUpd"})
	public Map<String, String> roleNameIsUnique(@RequestParam Map<?, ?> reqParamsMap)
	{
		String isUnique="FALSE";
		//声明功能变量
		String roleId=(String)reqParamsMap.get("roleId");
		if(roleId.trim().isEmpty()){throw new IFException("角色Id不能为空");}
		String name=(String)reqParamsMap.get("name");
		SysLoginRoleType role = iSysRoleDao.queryByName(name);
		if(role!=null && !roleId.equals(role.getRole().toString()) )
		{
			isUnique="TRUE";
	    }
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", isUnique);
		return map;
	}
	/**
	 * 角色信息 - 修改
	 */
	@RequestMapping(value="/Sys/Role/{roleId}", method={RequestMethod.POST})
	@Transactional
	public Long modifySysRole(@PathVariable Long roleId, @RequestBody SysRoleBean sysRoleBean) {

		String name = sysRoleBean.getName();
		if("".equals(Util.toStringAndTrim(name)))
			throw new IFException("名称不能为空");

		Long deptId = sysRoleBean.getDeptId();
		if(deptId==null)
			throw new IFException("企业或部门不能为空");

		//	1-修改角色
		SysLoginRoleType role = new SysLoginRoleType();

		role.setRole(roleId);
		role.setName(name);
		role.setNote(sysRoleBean.getNote());
		role.setParty(new Party(deptId));
		role.setState(0);	//	0-启用
		role.setUpdateTime(new Date());

		update(role);

		//	2.1-删除角色与功能关系
		sysRoleFunDao.deleteByRole(new SysLoginRoleType(roleId));

		//	2.2-新增角色与功能关系
		List<Long> function = sysRoleBean.getFuncInfo();
		if(function==null || function.size()<=0)
			return roleId;

		for(Long functionId : function){
			SysRoleFun roleFun = new SysRoleFun();

			roleFun.setFunction(new ProdFunSet(functionId));
			roleFun.setRole(role);

			insert(roleFun);
			}

		return roleId;
		}

	/**
	 * 角色信息 - 删除
	 */
	@RequestMapping(value="/Sys/Role/{roleId}", method={RequestMethod.DELETE})
	@Transactional
	public Long deleteSysRole(@PathVariable Long roleId) {

		if(roleId==null)
			throw new IFException("角色标识不能为空");

		SysLoginRoleType originRole = queryOne(new SysLoginRoleType(roleId));
		if(originRole==null)
			return roleId;

		originRole.setState(2);	//	2-删除
		originRole.setUpdateTime(new Date());

		update(originRole);

		return roleId;
		}

	/********************************************************************************/ /********************************************************************************/

	/**
	 * 功能信息 - 列表查询
	 */
	@RequestMapping(value="/Sys/Func", method={RequestMethod.POST})
	public Page<?> searchFunSet(@RequestBody FunSetSearchBean funSetSearchBean) {

		Map<String,Object> sqlParamsMap = new HashMap<String,Object>();

		StringBuffer listSql = new StringBuffer();
		StringBuffer countSql = new StringBuffer();
		
		listSql.append("SELECT new Map(func.functionId as functionId,func.name as name,func.note as note) FROM ProdFunSet func");
		
		countSql.append("SELECT count(1) FROM ProdFunSet func");
		
		if(Util.isNotNullOrEmpty(funSetSearchBean.getFunType()))
		{
			sqlParamsMap.put("funType", funSetSearchBean.getFunType());
			listSql.append(" WHERE func.funType=:funType ");
			countSql.append(" WHERE func.funType=:funType ");
		}
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,funSetSearchBean.getPageRequest());

		return datas;
		}

	/********************************************************************************/ /********************************************************************************/

	/**
	 * 单个文件上传
	 * @return
	 * uploadName：原文件名
	 * saveName：保存文件名
	 * saveDir：保存路径
	 */
	@RequestMapping(value="/File/Upload", method={RequestMethod.POST})
	public Map<String,String> uploadFile(MultipartHttpServletRequest request) {

		Map<String,String> data = new HashMap<String,String>();

		File fileUploadPath = new File(tmpInfoFilePath);
		if(!fileUploadPath.exists())
			fileUploadPath.mkdirs();

		MultipartFile file = request.getFile("file");
		String realFileName = null;
		if(!file.isEmpty()){
			String originalFileName = file.getOriginalFilename();

			data.put("uploadName",originalFileName);

			realFileName = String.valueOf(System.currentTimeMillis()) + originalFileName.substring(originalFileName.lastIndexOf("."));

			data.put("saveName",realFileName);
			data.put("saveDir",tmpInfoFilePath);

			try{
				byte[] bytes = file.getBytes();

				FileOutputStream fos = new FileOutputStream(tmpInfoFilePath + File.separator + realFileName);

				fos.write(bytes);
				fos.close();
				}
			catch(IOException e){
				e.printStackTrace();
				throw new IFException("上传文件出错" + e.getStackTrace());
				}
			}

		return data;
		}

	/**
	 * 单个文件下载
	 */
	@RequestMapping(value="/File/Download/{uploadId}", method={RequestMethod.GET,RequestMethod.HEAD})
	public void downloadFile(HttpServletRequest request, HttpServletResponse response, @PathVariable Long uploadId) {

		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");

		Boolean isOnLine = false;	//	是否在线浏览

		//	查询文件信息
		UploadFileInfo uploadFile = queryOne(new UploadFileInfo(uploadId));
		if(uploadFile==null)
			throw new IFException("文件不存在");

		StringBuffer path = new StringBuffer(uploadFile.getSaveDir()).append(File.separator).append(uploadFile.getSaveName());

		File file = new File(path.toString());
		FileInputStream fileInput = null;
		BufferedInputStream buffInput = null;
		OutputStream out = null;
		try{
			if(!file.exists())
				throw new IFException("文件不存在");

			response.reset();

			if(isOnLine){//	在线浏览方式
				URL url = new URL("file:///" + path.toString());

				response.setContentType(url.openConnection().getContentType());
				response.setHeader("Content-Disposition","inline; filename=" + new String(uploadFile.getUploadName().getBytes("gbk"),"iso-8859-1"));
				}
			else{//	纯下载方式
				//	设置response的编码方式
				response.setContentType("application/x-msdownload");
				//	写明要下载的文件的大小
				Long length = new Long(file.length());

				response.setContentLength(length.intValue());
				//	设置附加文件名(解决中文乱码)
				response.setHeader("Content-Disposition","attachment; filename=" + new String(uploadFile.getUploadName().getBytes("gbk"),"iso-8859-1"));
				}

			fileInput = new FileInputStream(file);

			buffInput = new BufferedInputStream(fileInput);

			byte[] buff = new byte[1024];	//	相当于我们的缓存
			long count = 0;	//	该值用于计算当前实际下载了多少字节
			//	从response对象中得到输出流,准备下载
			out = response.getOutputStream();
			while(count<file.length()){
				int i = buffInput.read(buff,0,1024);
				count += i;
				//	将buff中的数据写到客户端的内存
				out.write(buff,0,i);
				}
			//	将写入到客户端的内存的数据,刷新到磁盘
			out.flush();
			}
		catch(IOException e){
			e.printStackTrace();
			throw new IFException("下载文件失败");
			}
		finally{
			try{
				if(fileInput!=null)
					fileInput.close();
				if(buffInput!=null)
					buffInput.close();
				if(out!=null)
					out.close();
				}
			catch(Exception e){
				e.printStackTrace();
				}
			}
		}

	}
