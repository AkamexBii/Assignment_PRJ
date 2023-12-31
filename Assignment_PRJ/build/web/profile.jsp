<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="./css/styleProfile.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
              integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            .image-file {
                top: -28px;
            }

            .image-file:hover {
                background-color: rgba(0,0,0,0.1);
            }
        </style>
    </head>

    <body>
        <div class="root flex">
            <div class="left bg-teal-500 basis-3/12 h-auto relative">
                <div class="back-home mt-6 ml-6">
                    <a href="home.jsp" class="text-3xl">
                        <i class="fa-solid fa-arrow-left text-white"></i> <span class="text-white">HOME</span>
                    </a>
                </div>
                <div class="image absolute top-0 h-56 w-56 rounded-full overflow-hidden">
                    <img class="h-full w-full"
                         src="${sessionScope.user.getImage()}"
                         alt="ava" />
                    <form id="avatar-form" action="changeavatar" method="post" enctype="multipart/form-data">
                        <input type="file" name="file" class="absolute image-file bottom-0 right-0 left-0 cursor-pointer" onchange="doChange()"/>
                    </form>
                </div>
            </div>
            <div class="right bg-white basis-9/12 h-full pt-32 pb-32 pl-56 pr-28">
                <div class="feature-divider bg-emerald-700"></div>
                <div class="info">
                    <form action="changeinfo">
                        <table>
                            <tr>
                                <th colspan="2">
                                    <h1 class="text-5xl mb-20">Personal Infomation</h1>
                                </th>
                            </tr>
                            <tr class="h-14">
                                <td colspan="1" class="text-xl font-medium">Username: </td>
                                <td colspan="1">
                                    <span class="text-xl">
                                        ${sessionScope.user.getUsername()}
                                    </span>
                                </td>
                            </tr>
                            <tr class="h-14">
                                <td colspan="1" class="text-xl font-medium">First Name: </td>
                                <td colspan="1">
                                    <input type="text" value="${sessionScope.user.getFirstName()}" style="border: 1px solid #000; border-radius: 4px;" class="fname-field-1 hidden text-lg fname" name="fname"/>
                                    <span class="text-xl fname-field-2">
                                        ${sessionScope.user.getFirstName()}
                                    </span>
                                </td>
                            </tr>
                            <tr class="h-14">
                                <td colspan="1" class="text-xl font-medium">Last Name: </td>
                                <td colspan="1">
                                    <input type="text" value="${sessionScope.user.getLastName()}" style="border: 1px solid #000; border-radius: 4px;" class="lname-field-1 hidden text-lg lname" name="lname"/>
                                    <span class="text-xl lname-field-2">
                                        ${sessionScope.user.getLastName()}
                                    </span>
                                </td>
                            </tr>
                            <tr class="h-14">
                                <td colspan="1" class="text-xl font-medium">Email: </td>
                                <td colspan="1">
                                    <input type="text" value="${sessionScope.user.getEmail()}" style="border: 1px solid #000; border-radius: 4px;" class="email-field-1 hidden text-lg email" name="email"/>
                                    <span class="text-xl email-field-2">
                                        ${sessionScope.user.getEmail()}
                                    </span>
                                </td>
                            </tr>
                            <c:if test="${requestScope.emailMessage != null}">
                                <tr class="">
                                    <td colspan="1"></td>
                                    <td colspan="1" class="text-base font-medium text-red-500">${requestScope.emailMessage}</td>
                                </tr>
                            </c:if>
                            <tr class="h-14">
                                <td colspan="1" class="text-xl font-medium">Phone: </td>
                                <td colspan="1">
                                    <input type="text" value="${sessionScope.user.getPhone()}" style="border: 1px solid #000; border-radius: 4px;" class="phone-field-1 hidden text-lg phone" name="phone"/>
                                    <span class="text-xl phone-field-2">
                                        ${sessionScope.user.getPhone()}
                                    </span>
                                </td>
                            </tr>
                            <c:if test="${requestScope.phoneMessage != null}">
                                <tr class="">
                                    <td colspan="1"></td>
                                    <td colspan="1" class="text-base font-medium text-red-500">${requestScope.phoneMessage}</td>
                                </tr>
                            </c:if>
                            <c:if test="${requestScope.updateMessage != null}">
                                <tr class="h-14">
                                    <td colspan="2" class="text-lg font-medium text-green-600">${requestScope.updateMessage}</td>
                                </tr>
                            </c:if>
                        </table>
                        <div class="change-pass-btn mt-10 mr-6 inline-block">
                            <button type="button" class="text-lg bg-fuchsia-800 text-white py-2 px-8 rounded hover:opacity-70 cursor-pointer">Change Password</button>
                        </div>
                        <div class="save-change mt-10 hidden inline-block">
                            <input type="submit" value="Save" class="text-lg bg-fuchsia-800 text-white py-2 px-8 rounded hover:opacity-70 cursor-pointer"/>
                        </div>
                        <div class="cancel-btn mt-10 hidden inline-block">
                            <input type="button" value="Cancel" class="text-lg bg-fuchsia-800 text-white py-2 px-8 rounded hover:opacity-70 cursor-pointer"/>
                        </div>
                        <div class="edit-btn mt-10 inline-block">
                            <input type="button" value="Edit" class="text-lg bg-fuchsia-800 text-white py-2 px-8 rounded hover:opacity-70 cursor-pointer"/>
                        </div>
                    </form>
                </div>
                <div class="feature-divider bg-emerald-700 mt-12"></div>
                <div class="address">
                    <form action="address" method="post">
                        <table class="w-full">
                            <tr>
                                <th colspan="3">
                                    <h1 class="text-5xl mb-20 float-left">Address</h1>
                                </th>
                            </tr>
                            <jsp:useBean id="u" class="dal.UserDAO"/>
                            <c:set var="i" value="0"/>
                            <c:forEach items="${u.getAddressByUserId(sessionScope.user.getUserId())}" var="ad">
                                <c:set var="i" value="${i+1}"/>
                                <tr class="h-14">
                                    <td colspan="1" class="w-32 text-xl font-medium">Address ${i}: </td>
                                    <td colspan="1" class="">
                                        <input type="text" value="${ad.getAddressLine()}" readonly class="text-lg"/>
                                    </td>
                                    <td colspan="1" class="text-center">
                                        <button type="button" class="bg-red-600 hover:bg-red-500 text-white w-8/12 h-9 rounded-lg" onclick="doRemoveAddress(${ad.getId()},${i})"><i class="fa-solid fa-x"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                        <div class="input-address h-14 hidden mt-6">
                            <input type="text" placeholder="Enter new Address" class="text-lg border-2 border-black w-9/12" name="address"/>
                            <input type="submit" value="Add" class="text-lg bg-fuchsia-800 text-white py-1 px-6 ml-5 rounded hover:opacity-70 cursor-pointer"/>
                        </div>
                        <div class="add-address-btn mt-10 mr-6 inline-block">
                            <input type="button" class="text-lg bg-fuchsia-800 text-white py-2 px-8 rounded hover:opacity-70 cursor-pointer" value="Add new Address"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>

</html>
<script type="text/javascript" src="/Project1/js/profile.js"></script>
<script>
                                            function doChange() {
                                                document.querySelector('#avatar-form').submit()
                                            }

                                            const fnameField1 = document.querySelector('.fname-field-1');
                                            const fnameField2 = document.querySelector('.fname-field-2');
                                            const lnameField1 = document.querySelector('.lname-field-1');
                                            const lnameField2 = document.querySelector('.lname-field-2');
                                            const emailField1 = document.querySelector('.email-field-1');
                                            const emailField2 = document.querySelector('.email-field-2');
                                            const phoneField1 = document.querySelector('.phone-field-1');
                                            const phoneField2 = document.querySelector('.phone-field-2');
                                            const editBtn = document.querySelector('.edit-btn');
                                            const cancelBtn = document.querySelector('.cancel-btn');

                                            editBtn.addEventListener('click', () => {
                                                fnameField1.classList.remove('hidden');
                                                fnameField2.classList.add('hidden');
                                                lnameField1.classList.remove('hidden');
                                                lnameField2.classList.add('hidden');
                                                emailField1.classList.remove('hidden');
                                                emailField2.classList.add('hidden');
                                                phoneField1.classList.remove('hidden');
                                                phoneField2.classList.add('hidden');
                                                editBtn.classList.add('hidden');
                                                saveBtn.classList.remove('hidden');
                                                cancelBtn.classList.remove('hidden');
                                            });

                                            cancelBtn.addEventListener('click', () => {
                                                fnameField2.classList.remove('hidden');
                                                fnameField1.classList.add('hidden');
                                                lnameField2.classList.remove('hidden');
                                                lnameField1.classList.add('hidden');
                                                emailField2.classList.remove('hidden');
                                                emailField1.classList.add('hidden');
                                                phoneField2.classList.remove('hidden');
                                                phoneField1.classList.add('hidden');
                                                editBtn.classList.remove('hidden');
                                                saveBtn.classList.add('hidden');
                                                cancelBtn.classList.add('hidden');
                                            })
</script>