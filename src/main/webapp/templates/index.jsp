<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="model.CryptoCoin" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%--
  Created by IntelliJ IDEA.
  User: gilang
  Date: 14/04/21
  Time: 07.32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
</head>

<body>
<!-- Headers -->
<div class="row" style="background-color: azure">
    <div class="col-md-8">
        <div style="padding: 30px; font-family: sans-serif">
            <h3 style="font-family: 'sans-serif'">Today's Coin Market Watch!</h3>
            <h6>The global Crypto market watchlist. Set your watchlist now and never miss
                any changes in coin prices!</h6>
        </div>
    </div>

    <div class="col-md-2" style="padding: 30px; text-align: right">
        <a class="btn btn-primary" style="margin-top: 20px;">
            <span class="glyphicon glyphicon-eye-open"></span> My Watchlist
        </a>
    </div>
</div>
<!-- Content -->
<div class="row">
    <div class="col-md-12">
        <table class="table table-striped">
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Price</th>
                <th>Market Cap</th>
                <th>Volume (24h)</th>
                <th>Circulating Supply</th>
                <th>Watchlist</th>
            </tr>

            <%
                NumberFormat formatter = NumberFormat.getInstance(new Locale("en_US"));
                List<CryptoCoin> coins = (List<CryptoCoin>) request.getAttribute("coins");

                List<String> cryptoWatchlist = (List<String>) request.getAttribute("crypto-coin-watchlist");

                for(int i = 0; i < coins.size(); i+=1) { %>
            <tr>
                <td><%=i + 1%></td>
                <td><img src="<%= coins.get(i).getIcon()%>" alt="btc-image" width="15px"> <%= coins.get(i).getName()%></td>
                <td>¥<%= formatter.format(coins.get(i).getPrice().longValue())%></td>
                <td>¥<%= formatter.format(coins.get(i).getMarketCap().longValue())%></td>
                <td>¥<%= formatter.format(coins.get(i).getVolume().longValue())%></td>
                <td><%= formatter.format(coins.get(i).getCirculatingSupply().longValue()) + " " + coins.get(i).getCode()%> </td>
                <td>
                    <!-- Coin already in watch list, toggle remove-->
                    <%
                        boolean isCoinInWatchlist = false;

                        //check if crypto watch list session is not empty, then iterate to check if
                        //current coin is in watchlist
                        if(cryptoWatchlist != null){
                            for(int watchListIndex = 0; watchListIndex < cryptoWatchlist.size(); watchListIndex++) {
                                if(cryptoWatchlist.get(watchListIndex).equals(coins.get(i).getCode())){
                                    isCoinInWatchlist = true;
                                }
                            }
                        }

                    if(isCoinInWatchlist){%>
                    <form action="watchlist/remove" method="post">
                        <input type="hidden" name="coin_code" value="<%=coins.get(i).getCode()%>">
                        <input type="submit" class="btn btn-danger" value="Remove from Watchlist">
                    </form>
                    <% }else{ %>
                    <form action="watchlist/add" method="post">
                        <input type="hidden" name="coin_code" value="<%=coins.get(i).getCode()%>">
                        <input type="submit" class="btn btn-primary" value="Add to Watchlist">
                    </form>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>
