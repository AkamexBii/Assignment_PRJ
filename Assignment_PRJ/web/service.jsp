<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Service</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
              integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>  
        <script src="//cdnjs.cloudflare.com/ajax/libs/list.js/1.5.0/list.min.js"></script>
        <style>
            .item:hover {
                background-color: rgba(0,0,0,0.05);
            }

            .pagination li {
                display:inline-block;
                padding:5px;
                border: 1px solid #ccc;
                margin: 0 4px;
            }
            
            .pagination li.active {
                background-color: #ccc;
            }
            
            ul.pagination {
                float: right;
            }
        </style>
    </head>
    <jsp:useBean id="s" class="dal.ServiceDAO" />
    <body>
        <div class="root">
            <div class="h-16 bg-zinc-900 w-screen py-3 px-8 fixed z-50 top-0" id="header">
                <div class="nav flex h-full justify-between">
                    <div class="logo basis-2/6 flex justify-center items-center"><span
                            class="block text-slate-100 text-3xl">Smart Beauty</span></div>
                    <div class="menu basis-3/6">
                        <ul class="flex justify-between items-center h-full text-slate-300">
                            <li><a href="home.jsp"
                                   class="hover:text-slate-100 relative after:absolute after:bottom-0 after:left-0 after:bg-slate-50 after:h-0.5 after:w-0 hover:after:w-full after:transition-all after:ease-in-out after:duration-300 uppercase">Home</a>
                            </li>
                            <li><a href="product.jsp"
                                   class="hover:text-slate-100 relative after:absolute after:bottom-0 after:left-0 after:bg-slate-50 after:h-0.5 after:w-0 hover:after:w-full after:transition-all after:ease-in-out after:duration-300 uppercase">Products</a>
                            </li>
                            <li><a href="service.jsp"
                                   class="hover:text-slate-100 relative after:absolute after:bottom-0 after:left-0 after:bg-slate-50 after:h-0.5 after:w-0 hover:after:w-full after:transition-all after:ease-in-out after:duration-300 uppercase">Service</a>
                            </li>
                            <c:if test="${sessionScope.user == null}">
                                <li><a href="login.jsp"
                                       class="hover:text-slate-100 relative after:absolute after:bottom-0 after:left-0 after:bg-slate-50 after:h-0.5 after:w-0 hover:after:w-full after:transition-all after:ease-in-out after:duration-300">Login</a>
                                </li>
                            </c:if>
                            <c:if test="${sessionScope.user != null}">
                                <li class="user">
                                    <a class="cursor-pointer">Hello ${sessionScope.user.getFirstName()} <img
                                            src="./image/arrowDown.png" class="inline h-4" /></a>
                                    <ul
                                        class="user-menu hidden absolute top-16 w-36 text-black shadow-2xl bg-white">
                                        <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white">
                                            Profile
                                        </li>
                                        <c:if test="${sessionScope.user.getRole() == 1}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white"
                                                onclick="goManagement()">
                                                Management
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.getRole() == 1}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white"
                                                onclick="goChart()">
                                                Chart
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.getRole() == 1}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white"
                                                onclick="goServiceManager()">
                                                Service(Admin)
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.getRole() == 1}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white"
                                                onclick="goUserManage()">
                                                Manage User
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.getRole() == 2}">
                                            <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white"
                                                onclick="goOrder()">
                                                View Orders
                                            </li>
                                        </c:if>
                                        <li class="px-5 py-3 cursor-pointer hover:bg-slate-700 hover:text-white">
                                            Logout
                                        </li>
                                    </ul>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                    <div class="cart flex basis-1/6 ml-16 flex items-center">
                        <a href="cart.jsp" class="h-full">
                            <img src="./image/cart.png" alt="cart" class="h-full" />
                        </a>
                        <span class="text-slate-100 mx-2">CART</span>
                        <span class="text-slate-100 rounded-xl bg-orange-700 px-2 py-1">${sessionScope.cart != null
                                                                                          ? sessionScope.cart.getList().size() + sessionScope.cart.getListService().size() : 0}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-24 flex justify-center">
            <h1 class="text-3xl font-bold">Services</h1>
        </div>
        <div class="px-6 mt-10">
            <div id="test-list">
                <input type="text" class="search" />
                <ul class="list">
                    <c:forEach items="${s.all}" var="sv">
                        <li>
                            <form class="rounded shadow-2xl flex cursor-pointer item mb-10 relative" action="book-service" method="post">
                                <img src="${sv.getImage()}" style="width: 200px; height: 200px; object-fit: contain; overflow: hidden" alt="imgage"/>
                                <div class="p-4 pr-36">
                                    <h2 class="text-2xl font-bold mb-4">${sv.getId()}. ${sv.getName()} <label style="color: green;">(${sv.getPrice()}$)</label></h2>
                                    <p>${sv.getDescription()}</p>
                                </div>
                                <input name="id" value="${sv.getId()}" type="hidden"/>
                                <div>
                                    <button class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800 absolute bottom-4 right-4">Book &#8594;</button>
                                </div>
                            </form>
                        </li>
                    </c:forEach>
                </ul>
                <ul class="pagination"></ul>
            </div>
        </div>
    </body>
</html>
<script type="text/javascript" src="/Project1/js/header.js"></script>
<script>
                                                    var monkeyList = new List('test-list', {
                                                        valueNames: ['name'],
                                                        page: 3,
                                                        pagination: true,

                                                    });
</script>
