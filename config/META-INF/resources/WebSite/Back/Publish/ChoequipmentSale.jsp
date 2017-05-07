<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!-- 出租信息新增模态框（Modal） -->
<div id="fade" class="modal fade"></div>
<div class="login_bg" id="openwin2" >
  <div class="ihhatitle1">设备信息</div>
  <div class="fbxx_top" >
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="gwafdg">
  <tr>
  <td width="9%"> </td>
    <td width="6%" ng-show="userInfo.orgLevel!=6">当前单位： </td>
    <td width="21%"> 
    	<div ng-if="!userInfo.proId" ng-show="userInfo.orgLevel!=6" class="input-group">
			<input ng-model="equQryBean.equAtOrgNameSelect" type="text" class="inpt_a inpt_o span230" style="margin-top: 6px; width: 70%; height: 34px; border-right: 0px; background-color: #fff;" readonly="readonly">
			<span class="input-group-btn" style="padding-top: 6px;">
				<button class="btn btn-default" type="button" style="width: 30px;margin-left:-230%; border-left: 0px; background-color: #fff;" ng-click="openEquAtEmployerModel()">…</button>
			</span>
		</div>
		
		<div ng-if="userInfo.proId" class="input-group">
			<input ng-model="userInfo.proName" type="text" class="inpt_a inpt_o span230" style="height: 34px; background-color: #fff;" readonly="readonly">
		</div>
		<!-- <input ng-show="userInfo.orgLevel!=6 && equQryBean.isCrecOrg==1" ng-model="equQryBean.equAtOrgNameInput" type="text" class="inpt_a inpt_o" style="margin-left: 0px;width:152px" /> -->
   </td>
    <!-- <td width="10%" ng-show="userInfo.orgLevel!=6">
	   	<div style="margin-top:-17px;margin-left:-4px" >
			<input ng-model="equQryBean.isCrecOrg" ng-true-value="1" ng-false-value="0" ng-click="click();" type="checkbox" style="position: absolute; z-index: 3; margin-left: -22px; margin-top: 10px;">
			<span contenteditable="false" class="control-label" style="text-align: left; position: absolute; z-index: 2; margin-left: -3px;">非中铁单位</span>
		</div>
    </td> -->
    <td width="13%" ng-if="!userInfo.proId" ng-show="userInfo.orgLevel!=6" >
     	<input name="" ng-model="equQryBean.isInclude" type="checkbox" ng-show="(equQryBean.equAtOrgFlag==9 || equQryBean.equAtOrgFlag==1 || equQryBean.equAtOrgFlag!=2 && equQryBean.equAtOrgFlag!=3)" ng-true-value="1" ng-false-value="0"  /><p ng-show="userInfo.orgLevel!=6&& (equQryBean.equAtOrgFlag==9 || equQryBean.equAtOrgFlag==1 || equQryBean.equAtOrgFlag!=2 && equQryBean.equAtOrgFlag!=3)" style="color: black;margin-top: -33px;margin-left: 14px">包含下级单位</p>
    </td>
    <td width="6%">设备名称：</td>
    <td width="21%">
       <input   type="text" class="inpt_a inpt_o span230" ng-blur="closeDiv('equName_');" ng-model="equNameObjSale.equName" ng-click="click_checkEquName();"/><!-- ng-model="searBean.equName" -->
         
         <div class="input_xl ihhaiut" id="equName_noSix"  ng-show="tableShow&&userInfo.orgLevel!=6"  style="margin-left: 776px;width: 230px;margin-top: 69px;text-align: center;">
           <ul class="inputleft">
             <li class="inputleft_title">设备分类</li>
             <li ng-show="allequi.length!==0" ng-repeat="c in allequi" ng-click="InputShow(c.equName,'searBean','equName','LiNumB',RentInfo.code,save_level);" ><a class="ss_link1" href="###" style="" title="{{c.equipmentCategoryName}}">{{c.equipmentCategoryNameTemp}}</a></li>
           </ul>
           <ul class="inputright">
             <li class="inputright_title">设备名称</li>
             <li ng-show="allequi.length!==0" ng-repeat="c in allequi" ng-click="InputShow(c.equName,'searBean','equName','LiNumB',RentInfo.code,save_level);"><a class="ss_link1" href="###" title="{{c.equName}}">{{c.equNameTemp}}</a></li>
           </ul>
           <div class="clear"></div>
         </div>
         
         <div class="input_xl ihhaiut" id="equName_Six"  ng-show="tableShow&&userInfo.orgLevel==6"  style="margin-left: 532px;width: 230px;margin-top: 63px;text-align: center;m">
           <ul class="inputleft">
             <li class="inputleft_title">设备分类</li>
             <li ng-show="allequi.length!==0" ng-repeat="c in allequi" ng-click="InputShow(c.equName,'searBean','equName','LiNumB',RentInfo.code,save_level);" ><a class="ss_link1" href="###" style="" title="{{c.equipmentCategoryName}}">{{c.equipmentCategoryNameTemp}}</li>
           </ul>
           <ul class="inputright">
             <li class="inputright_title">设备名称</li>
             <li ng-show="allequi.length!==0" ng-repeat="c in allequi" ng-click="InputShow(c.equName,'searBean','equName','LiNumB',RentInfo.code,save_level);"><a class="ss_link1" href="###" title="{{c.equName}}">{{c.equNameTemp}}</a></li>
           </ul>
           <div class="clear"></div>
         </div>
         
    </td>
    <td width="24%">  <input class="inpt_booom inpt_booom_pol" value="查询" type="submit" ng-click="search(equNameObjSale.equName,userInfo.Name);"/>
    </td>
  </tr>
</table>
     <div class="clear"></div>

   </div>
   
	 <div class="mar_t15">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tab_hj table-hover">
        <tr>
	                        <th style="text-align: center;">序号</th>
	                        <th style="text-align: center;" ng-show="userInfo.orgLevel!=6"">局级单位</th>
	                        <th style="text-align: center;" ng-show="userInfo.orgLevel!=6">子公司名称</th>
	                        <th style="text-align: center;" ng-show="userInfo.orgLevel!=6">项目名称</th>
	                        <th style="text-align: center;" ng-show="userInfo.orgLevel==6">单位名称</th>	                        
	                        <th style="text-align: center;">设备编号</th>
	                        <th style="text-align: center;">设备名称</th>
	                        <th style="text-align: center;">品牌</th>
	                        <th style="text-align: center;">型号</th>
	                        <th style="text-align: center;">规格</th>
	                        <th style="text-align: center;">功率(KW)</th>
	                        <th style="text-align: center;">技术状况</th>
	                        <th style="text-align: center;">生产厂家</th>
	                        <th style="text-align: center;">出厂日期</th>
        </tr>
        <tr ng-repeat="t in allequiList" ng-click="Select(t,$index);" ng-dblclick="queryequiData();" style="text-align: center;">
	                        <td href="javascript:void(0);"><p style="float: left;margin-top: 2px;margin-left: 7px;" 	><input type="radio"  ng-checked="radioTrIndex==$index"/></p>
	                       {{$index+1+(paginationConf.currentPage-1)*paginationConf.itemsPerPage}}</td>
	                       <td ng-show="userInfo.orgLevel!=6" title="{{t.bureauOrgPartyName}}">{{t.bureauOrgPartyNameTemp}}</td> 
	                        <td ng-show="userInfo.orgLevel==6">{{parentOrg.name}}</td>
	                        <td ng-show="userInfo.orgLevel!=6" title="{{t.sonOrgName}}">{{t.sonOrgNameTemp}}</td>
	                        <td ng-show="userInfo.orgLevel!=6" title="{{t.proOrgName}}">{{t.proOrgNameTemp}}</td>
	                         <td title="{{t.equNo}}">{{t.equNoTemp}}</td>
	                        <td title="{{t.equName}}">{{t.equName}}</td>
	                        <td title="{{t.brandName}}">{{t.brandNameTemp}}</td>
	                        <td title="{{t.models}}">{{t.modelsTemp}}</td>
	                        <td title="{{t.specifications}}">{{t.specificationsTemp}}</td>
	                        <td title="{{t.power}}">{{t.powerTemp}}</td>
	                        <td ng-model="t.technicalStatus">
                            <span ng-show="t.technicalStatus==1">一类</span>
                            <span ng-show="t.technicalStatus==2">二类</span>
                            <span ng-show="t.technicalStatus==3">三类</span>
                            </td>
	                        <td title="{{t.manufacturerName}}">{{t.manufacturerNameTemp}}</td>
	                        <td>{{t.productionDate}}</td>
	                    </tr>
      </table>

   </div>
   <div class="goper">
       <div ng-show="allequiList.length!=0" style="margin-top: -30px; float:right;">
                    <tm-paginationrentsale conf="paginationConf" ng-click="queryallequiData();"></tm-paginationrentsale>
       </div>
  </div>
       
       <div class="ihhaanns"><a class="iehi_d left" href="####" ng-click="queryequiData();" ng-show="allequiList.length!=0" style="margin-left: 960px;margin-top: -10px">确认</a><a class="iehi_d left close_openwin" ng-show="allequiList.length!=0" href="####" ng-click="close();" style="margin-top: -10px">关闭</a>
         <a class="iehi_d left close_openwin" href="####" ng-show="allequiList.length==0" style="margin-left:1070px;margin-top: -10px" ng-click="close();">关闭</a>
       </div>

	  </div>
	