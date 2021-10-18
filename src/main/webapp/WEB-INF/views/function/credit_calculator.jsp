<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form"%>

<!-- 절대경로 설정   -->
<c:set var="path" value="${pageContext.request.contextPath}/" />

<!DOCTYPE html>
<html lang="en">

<head>
   <title>유니티</title>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
   <link rel="stylesheet" href="${path}resources/css_myPage/style.css">
</head>

   <c:import url="/WEB-INF/views/include/head_meta.jsp" />
   <c:import url="/WEB-INF/views/include/top_menu.jsp" />
   
<body style="background:linear-gradient(94deg,rgba(30, 161, 247,0.3), rgba(70, 207, 167, 0.3));"> 
   <section class="ftco-section" style="font-family: Jua, sans-serif;">
      <div class="container">
         <div class="row justify-content-center">
            <div class="col-md-6 text-center mb-4"></div>
         </div>
         <div class="row">
            <div class="col-md-12">
               <h3 class="mb-4 text-center" style="font-weight: bold;">학점 계산기</h3>
           
                    <input style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer;" type="button"  value="과목추가" onclick="addRow();" id="addSubject"/>
                    <input style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer;" type="button"  value="과목삭제" onclick="deleteRow();" id="deleteSubject"/>
                 <br>   
               <div class="table-wrap">
                  <table class="table" id="cal" >
                     <thead style="background:linear-gradient(94deg,#46cfa7,#1ea1f7);">
                        <tr>
                           <th>&nbsp;</th>
                           <th style="font-weight: bold; font-size: 1em">전공</th>
                           <th style="font-weight: bold; font-size: 1em">과목명</th>
                           <th style="font-weight: bold; font-size: 1em">점수</th>
                           <th style="font-weight: bold; font-size: 1em">학점</th>
                           
                        </tr>
                     </thead>
                     <tbody>
                        <tr class="alert" role="alert">
                           <td></td>
                           
                           <td>
                              <label class="">
                                 <input type="checkbox" checked name="checkMajor"> 
                              </label>
                           </td>

                           <td>
                              <input type="text">
                           </td>
                           
                           <td>
                              <select class="form-control rounded-left" name="credit" id="credit_1"  onchange="selectChange(1, this.value);">
                                 <option value="">선택</option>
                                 <option value="A+" >A+</option>
                                 <option value="A" >A</option>
                                 <option value="B+" >B+</option>
                                 <option value="B" >B</option>
                                 <option value="C+" >C+</option>
                                 <option value="C" >C</option>
                                 <option value="D+" >D+</option>
                                 <option value="D" >D</option>
                                 <option value="F" >F</option>
                              </select>
                           </td>
                        
                           <td>
                              <input type="text" name="score" id="score_1" value="" >   
                           </td>
                           
                        </tr>
                        
                        <tr class="alert" role="alert">
                           <td></td>
                           
                           <td>
                              <label class="">
                                 <input type="checkbox" checked name="checkMajor"> 
                              </label>
                           </td>

                           <td>
                              <input type="text">
                           </td>
                           
                           <td>
                              <select class="form-control rounded-left" name="credit" id="credit_2" onchange="selectChange(2, this.value);">
                                 <option value="">선택</option>
                                 <option value="A+" >A+</option>
                                 <option value="A" >A</option>
                                 <option value="B+" >B+</option>
                                 <option value="B" >B</option>
                                 <option value="C+" >C+</option>
                                 <option value="C" >C</option>
                                 <option value="D+" >D+</option>
                                 <option value="D" >D</option>
                                 <option value="F" >F</option>
                              </select>
                           </td>
                        
                           <td>
                              <input type="text" name="score" id="score_2" value="" >   
                           </td>
                           
                        </tr>
                        
                        <tr class="alert" role="alert">
                           <td></td>
                           
                           <td>
                              <label class="">
                                 <input type="checkbox" checked name="checkMajor" value="123456"> 
                              </label>
                           </td>

                           <td>
                              <input type="text">
                           </td>
                           
                           <td>
                              <select class="form-control rounded-left" name="credit" id="credit_3" onchange="selectChange(3, this.value);">
                                 <option value="">선택</option>
                                 <option value="A+" >A+</option>
                                 <option value="A" >A</option>
                                 <option value="B+" >B+</option>
                                 <option value="B" >B</option>
                                 <option value="C+" >C+</option>
                                 <option value="C" >C</option>
                                 <option value="D+" >D+</option>
                                 <option value="D" >D</option>
                                 <option value="F" >F</option>
                              </select>
                           </td>
                        
                           <td>
                              <input type="text" name="score" id="score_3" value="" >   
                           </td>
                           
                        </tr>
                        
                        <tr class="alert" role="alert">
                           <td></td>
                           
                           <td>
                              <label class="">
                                 <input type="checkbox" checked name="checkMajor"> 
                              </label>
                           </td>

                           <td>
                              <input type="text">
                           </td>
                           
                           <td>
                              <select class="form-control rounded-left" name="credit" id="credit_4" onchange="selectChange(4, this.value);">
                                 <option value="">선택</option>
                                 <option value="A+" >A+</option>
                                 <option value="A" >A</option>
                                 <option value="B+" >B+</option>
                                 <option value="B" >B</option>
                                 <option value="C+" >C+</option>
                                 <option value="C" >C</option>
                                 <option value="D+" >D+</option>
                                 <option value="D" >D</option>
                                 <option value="F" >F</option>
                              </select>
                           </td>
                        
                           <td>
                              <input type="text" name="score" id="score_4" value="" >   
                           </td>
                           
                        </tr>
                     </tbody>
                  </table>
               </div>
            </div>
         </div>
         <br>
         <div>
            <button style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right;" onClick="calculate()">계산하기</button>
         </div>
         <br><br>
         <div>
            <table>
               <thead>
                  <tr style="text-align:center">
                     <th class="calculate_table" style="font-weight: bold; font-size:1em; display:none; color:red;">
                        계산 결과 : 총 평점 <div id="total_ave" style="display:inline;"></div>/4.5 
                        전공 평점 <div id="major_ave" style="display:inline;"></div>/4.5
                        전체이수 <div id="credits_taken" style="display:inline;"></div>학점
                        전공이수 <div id="major_taken" style="display:inline;"></div>학점
                     </th>
                  </tr>
               </thead>
            </table>
         </div>
      </div>
   </section>
</body>

   <script type="text/javascript">
      function calculate(){
         
         var size = $("input[name='score']").length;
         var credits_taken=0;
         var major_taken=0;
         var major_ave=0;
         var total_ave=0;

         for(i=0;i<size;i++){
            if(!$("input[name='score']").eq(i).val()){
               if(!$("select[name='credit']").eq(i).val()){
                  continue;
               }
               alert("정확한 수치를 모두 입력해주세요.");
               break;
            }
         
              credits_taken += parseInt($("input[name='score']").eq(i).val());   
              if($("input:checkbox[name='checkMajor']").eq(i).is(":checked") == true) {
                 major_taken += parseInt($("input[name='score']").eq(i).val());
              }
              
              switch ($("select[name='credit']").eq(i).val()) {
                case "A+":
                 total_ave += 4.5 * parseInt($("input[name='score']").eq(i).val());
                  if($("input:checkbox[name='checkMajor']").eq(i).is(":checked") == true){
                     major_ave += 4.5 * parseInt($("input[name='score']").eq(i).val());
                  }
                 break;
                case "A":
                 total_ave += 4.0 * parseInt($("input[name='score']").eq(i).val());
                 if($("input:checkbox[name='checkMajor']").eq(i).is(":checked") == true){
                     major_ave += 4.0 * parseInt($("input[name='score']").eq(i).val());
                  }
                 break;
                case "B+":
                  total_ave += 3.5 * parseInt($("input[name='score']").eq(i).val());
                  if($("input:checkbox[name='checkMajor']").eq(i).is(":checked") == true){
                     major_ave += 3.5 * parseInt($("input[name='score']").eq(i).val());
                  }
                  break;
                case "B":
                  total_ave += 3.0 * parseInt($("input[name='score']").eq(i).val());
                  if($("input:checkbox[name='checkMajor']").eq(i).is(":checked") == true){
                     major_ave += 3.0 * parseInt($("input[name='score']").eq(i).val());
                  }
                  break;
                case "C+":
                 total_ave += 2.5 * parseInt($("input[name='score']").eq(i).val());
                 if($("input:checkbox[name='checkMajor']").eq(i).is(":checked") == true){
                     major_ave += 2.5 * parseInt($("input[name='score']").eq(i).val());
                  }
                 break;
                case "C":
                 total_ave += 2.0 * parseInt($("input[name='score']").eq(i).val());
                 if($("input:checkbox[name='checkMajor']").eq(i).is(":checked") == true){
                     major_ave += 2.0 * parseInt($("input[name='score']").eq(i).val());
                  }
                 break;
                  case "D+":
                   total_ave += 1.5 * parseInt($("input[name='score']").eq(i).val());
                   if($("input:checkbox[name='checkMajor']").eq(i).is(":checked") == true){
                     major_ave += 1.5 * parseInt($("input[name='score']").eq(i).val());
                  }
                   break;
               case "D":
                total_ave += 1.0 * parseInt($("input[name='score']").eq(i).val());
                if($("input:checkbox[name='checkMajor']").eq(i).is(":checked") == true){
                     major_ave += 1.0 * parseInt($("input[name='score']").eq(i).val());
                  }
                break;
               case "F":
                total_ave += 0;
                if($("input:checkbox[name='checkMajor']").eq(i).is(":checked") == true){
                     major_ave += 0;
                  }
                break;
                default:
                 alert("정확한 수치를 모두 입력해주세요.");
                   return;
              }
         }

         if(total_ave != 0){
            total_ave = total_ave/credits_taken;
         }
         if(major_ave != 0){
            major_ave = major_ave/major_taken;
         }
         
         
         document.getElementById("total_ave").innerHTML=total_ave.toFixed(2);
         document.getElementById("major_ave").innerHTML=major_ave.toFixed(2);
         document.getElementById("credits_taken").innerHTML=credits_taken; //전체 학점 더해줌
         document.getElementById("major_taken").innerHTML=major_taken; //전공 체크 한 것만 더해줌
         
         
         $(".calculate_table").css("display","block");
      }
    
      
   function addRow(){
       const table = document.getElementById('cal');
       
       // 새 행(Row) 추가
       const newRow = table.insertRow();
       const newIndex = table.rows.length-1;
       
       // 새 행(Row)에 Cell 추가
       const newCell1 = newRow.insertCell(0);
       const newCell2 = newRow.insertCell(1);
       const newCell3 = newRow.insertCell(2);
       const newCell4 = newRow.insertCell(3);
       const newCell5 = newRow.insertCell(4);      
       
       newCell1.innerHTML = "<td></td>";
       newCell2.innerHTML = "<td>"
                      + "<label class=''>"
                      + "<input type='checkbox' checked name='checkMajor'>"
                      + "</label>"
                      + "</td>";
       newCell3.innerHTML = "<td>"
                      + "<input type='text'>"
                      + "</td>";

       newCell4.innerHTML = "<td style='display:inline;'> "                               
                       +"<select class='form-control rounded-left' name='credit' id='credit_"+newIndex+"' onchange='selectChange("+newIndex+",this.value);'> "
                       +"<option value=''>선택</option> "
                       +"<option value='A+' >A+</option> " 
                       +"<option value='A' >A</option> " 
                       +"<option value='B+' >B+</option> " 
                       +"<option value='B' >B</option> " 
                       +"<option value='C+' >C+</option> " 
                       +"<option value='C' >C</option> " 
                       +"<option value='D+' >D+</option> " 
                       +"<option value='D' >D</option> " 
                       +"</select> " 
                       +"</td> "
       
       newCell5.innerHTML =  "<td style='display:inline;'> " 
                          +" <input type='text' name='score' id='score_"+newIndex+"' > " 
                          +" </td> " 
                  
                       
          
       //alert("addRow()");
    }
   
   function deleteRow(){
      const tableData = document.getElementById('cal')
   
      console.log('tableData.rows.length-->',tableData.rows.length);
      if(tableData.rows.length===2) return;
     tableData.deleteRow(tableData.rows.length-1);
      
     console.log('tableData' , tableData);
     //alert("deleteRow()");
  
   }   
    
    
   </script>
   <script src="${path}resources/js_myPage/jquery.min.js"></script>
   <script src="${path}resources/js_myPage/popper.js"></script>
   <script src="${path}resources/js_myPage/bootstrap.min.js"></script>
   <script src="${path}resources/js_myPage/main.js"></script>
   
   <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
