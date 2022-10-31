<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<table id="listTable" class="table-list table table-sm table-bordered mb-3">
							<colgroup>
								<col width="5%"/>
								<col width="5%"/>
								<col width="15%"/>
								<col width="10%"/>
								<col width="15%"/>
								<col width="10%"/>
								<col width="15%"/>
								<col width="10%"/>
								<col width="15%"/>
							</colgroup>
							<thead>
							<tr>
								<th colspan="7">설비이력카드</th>
								<th>사업소명</th>
								<th>전주환경사업소</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<th colspan="2">설비명</th>
								<td colspan="3">
									<input type="text" class="form-control form-control-sm" name="facility_name"
										   maxlength="20" value="${facility.facility_name}">
								</td>
								<th>공종</th>
								<td>
									<select name="construction_code" class="form-control form-control-sm">
										<c:forEach var="constructionType" items="${constructionTypes}"
												   varStatus="status">
											<option value="${constructionType.construction_code}">${constructionType.construction_name}</option>
										</c:forEach>
									</select>
								</td>
								<th>구분</th>
								<td>
									<select name="category_code" class="form-control form-control-sm">
										<c:forEach var="category" items="${categories}"
												   varStatus="status">
											<option value="${category.category_code}">${category.category_name}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th colspan="2">TAG NO.</th>
								<td>
									<input type="text" class="form-control form-control-sm" name="facility_tag_no"
										   maxlength="20" value="${facility.facility_tag_no}">
								</td>
								<th>설치장소</th>
								<td>
									<input type="text" class="form-control form-control-sm" name="emplacement"
										   maxlength="50" value="${facility.emplacement}">
								</td>
								<th>수량</th>
								<td>
									<input type="text" class="form-control form-control-sm" name="facility_quantity"
										   value="${facility.facility_quantity}">
								</td>
								<th>구입가격</th>
								<td>
									<input type="text" class="form-control form-control-sm" name="purchase_price"
										   value="${facility.purchase_price}">
								</td>
							</tr>
							<tr>
								<th colspan="2">제작회사</th>
								<td>
									<input type="text" class="form-control form-control-sm" name="production_company"
										   maxlength="50" value="${facility.production_company}">
								</td>
								<th>형식</th>
								<td>
									<input type="text" class="form-control form-control-sm" name="form" maxlength="50"
										   value="${facility.form}">
								</td>
								<th>제작일자</th>
								<td>${facility.manufacture_date}</td>
								<th>준공일자</th>
								<td>${facility.completion_date}</td>
							</tr>
							<tr>
								<th colspan="2">설치업체</th>
								<td>
									<input type="text" class="form-control form-control-sm" name="installer"
										   maxlength="50"
										   value="${facility.installer}">
								</td>
								<th>제원</th>
								<td>
									<input type="text" class="form-control form-control-sm" name="specification"
										   maxlength="50"
										   value="${facility.specification}">
								</td>
								<th>내구연한</th>
								<td>${facility.durable}</td>
								<th>대수선 준공일자</th>
								<td>${facility.major_repaircompletion_date}</td>
							</tr>
							<tr>
								<th colspan="2">설치용도</th>
								<td colspan="3">
									<input type="text" class="form-control form-control-sm" name="installation_purpose"
										   maxlength="50"
										   value="${facility.installation_purpose}">
								</td>
								<th>대수선 내용</th>
								<td>
									<input type="text" class="form-control form-control-sm" name="major_repair_content"
										   maxlength="50"
										   value="${facility.major_repair_content}">
								</td>
								<th>대수선 설치업체</th>
								<td>
									<input type="text" class="form-control form-control-sm"
										   name="major_repair_installer" maxlength="50"
										   value="${facility.major_repair_installer}">
								</td>
							</tr>
							<tr>
								<th rowspan="3">전동기</th>
								<th>형식</th>
								<td></td>
								<th>회전수</th>
								<td></td>
								<th>제작회사</th>
								<td colspan="3"></td>
							</tr>
							<tr>
								<th>용량</th>
								<td></td>
								<th>기동방법</th>
								<td></td>
								<th rowspan="2">모터 베어링 No.</th>
								<td></td>
								<th rowspan="2">펌프/감속기 베어링 No.</th>
								<td></td>
							</tr>
							<tr>
								<th>전원</th>
								<td></td>
								<th>제작일자</th>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							</tbody>
						</table>

						<table class="table-list table table-sm table-bordered">
							<colgroup>
								<col width="40%"/>
								<col width="5%"/>
								<col width="15%"/>
								<col width="15%"/>
								<col width="5%"/>
								<col width="15%"/>
								<col width="5%"/>
							</colgroup>
							<thead>
							<tr>
								<th>사진</th>
								<th colspan="5">기타 설비 및 부속설비</th>
								<th>
									<button class="btn btn-sm btn-primary">추가</button>
								</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td rowspan="9">
									<img src="">
								</td>
								<th>순번</th>
								<th>품명</th>
								<th>제원</th>
								<th>수량</th>
								<th>제작회사</th>
								<th>비고</th>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(function () {

	});
</script>
