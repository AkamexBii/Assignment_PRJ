<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
              integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <jsp:useBean id="pd" class="dal.ProductDAO" />
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
                                                                                          ? sessionScope.cart.getList().size() : 0}</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="mt-24 p-6">
            <c:if test="${requestScope.item != null}">
                <div class="flex">
                    <img src="${requestScope.item.getImage()}" alt="product_image" style="border: 1px solid #ccc;"/>
                    <div class="ml-12">
                        <h1 class="text-5xl mb-6 font-bold">${requestScope.item.getName()}</h1>
                        <p class="text-xl mb-4">Price: <strong>${requestScope.item.getUnitPrice()}$</strong></p>
                        <p class="text-xl mb-4">Unit in stock <strong>${requestScope.item.getUnitInStock()}</strong></p>
                        <p>
                            <strong>Description: </strong>
                            ${requestScope.item.getDescription()}
                        </p>
                        <div class="mt-4">
                            <h1 class="text-3xl mb-6 font-bold">Reviews</h1>
                            <c:forEach items="${pd.getAllReviewByProductId(requestScope.item.getId())}" var="r">
                                <h1 class="mb-2">
                                    <strong>${r.getUserName()}(<label style="color: red;">${r.getScore()}&bigstar;</label>):
                                    </strong>
                                    ${r.getText()}
                                </h1>
                            </c:forEach>
                        </div>
                        <c:if test="${sessionScope.user != null && requestScope.item != null}">
                            <c:if test="${pd.canReview(sessionScope.user.getUserId(),requestScope.item.getId())}">
                                <div>
                                    <button class="showFeedback text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Feedback</button>
                                </div>
                                <form class="hidden formFeedback" action="feedback" method="post">
                                    <h1 class="my-3 text-2xl font-bold">Write your feedback</h1>
                                    <label>review: </label>
                                    <input name="text" class="border-2 rounded w-full px-2" placeholder="review..."/>
                                    <input name="userId" value="${sessionScope.user.getUserId()}" type="hidden"/>
                                    <input name="productId" value="${requestScope.item.getId()}" type="hidden"/>
                                    <label>Score: </label>
                                    <select class="border-2 rounded w-full px-2" name="score">
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                    </select>
                                    <button type="submit" class="mt-4 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Submit</button>
                                </form>
                            </c:if>
                        </c:if>
                    </div>
                </div>
            </c:if>
        </div>
    </body>
</html>

<script type="text/javascript" src="/Project1/js/header.js"></script>
<script>
    const showFeedbackBtn = document.querySelector('.showFeedback');
    const formFeedback = document.querySelector('.formFeedback');
    
    showFeedbackBtn.addEventListener('click', () => {
        formFeedback.classList.remove("hidden");
        showFeedbackBtn.classList.add("hidden");
    })
</script>