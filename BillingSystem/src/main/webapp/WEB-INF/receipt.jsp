<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.foodorder.model.OrderItem" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Billing System – Receipt</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg:     #F2EDE4;
            --paper:  #FAF7F2;
            --ink:    #141414;
            --muted:  #8C8070;
            --accent: #C8552A;
            --border: 2.5px solid var(--ink);
            --sh:     4px 4px 0 var(--ink);
            --sh-sm:  3px 3px 0 var(--ink);
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: var(--bg); font-family: 'DM Mono', monospace; min-height: 100vh; padding: 28px 20px 48px; }
        .header { max-width: 1100px; margin: 0 auto 22px; display: flex; align-items: baseline; gap: 18px; border-bottom: var(--border); padding-bottom: 16px; }
        .logo { font-family: 'DM Serif Display', serif; font-size: 48px; color: var(--ink); line-height: 1; letter-spacing: -1px; }
        .logo span { color: var(--accent); }
        .tagline { font-size: 10px; letter-spacing: 2.5px; text-transform: uppercase; color: var(--muted); }
        .layout { max-width: 1100px; margin: 0 auto; display: grid; grid-template-columns: 185px 1fr 278px; border: var(--border); box-shadow: var(--sh); background: var(--paper); min-height: 520px; }
        .col { display: flex; flex-direction: column; }
        .col + .col { border-left: var(--border); }
        .col-head { font-size: 10px; font-weight: 500; letter-spacing: 3px; text-transform: uppercase; padding: 11px 14px; border-bottom: var(--border); color: var(--muted); background: var(--paper); }
        .left-col { background: var(--paper); }
        .middle-col { display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 40px 20px; gap: 16px; }
        .middle-col p { font-size: 11px; color: var(--muted); letter-spacing: 1px; text-transform: uppercase; text-align: center; }
        .order-ref { font-size: 13px; color: var(--ink); font-weight: 600; letter-spacing: 2px; }
        .new-order-btn { font-family: 'DM Mono', monospace; font-size: 10px; font-weight: 500; letter-spacing: 2px; text-transform: uppercase; padding: 10px 24px; border: var(--border); background: var(--ink); color: var(--paper); cursor: pointer; box-shadow: var(--sh-sm); text-decoration: none; display: inline-block; transition: transform 0.1s, box-shadow 0.1s; }
        .new-order-btn:hover { transform: translate(-1px,-1px); box-shadow: 4px 4px 0 var(--ink); }
        .receipt-col { display: flex; flex-direction: column; padding: 14px; gap: 10px; }
        .totals { display: flex; flex-direction: column; border: var(--border); }
        .t-row { display: flex; border-bottom: 1.5px solid var(--ink); }
        .t-row:last-child { border-bottom: none; }
        .t-lbl { width: 72px; padding: 7px 10px; font-size: 9px; font-weight: 500; letter-spacing: 2px; text-transform: uppercase; color: var(--muted); border-right: 1.5px solid var(--ink); flex-shrink: 0; }
        .t-val { flex: 1; font-family: 'DM Mono', monospace; font-size: 11px; font-weight: 500; color: var(--ink); padding: 0 8px; min-height: 34px; min-width: 0; overflow: hidden; white-space: nowrap; display: flex; align-items: center; justify-content: flex-end; letter-spacing: -0.5px; }
        .t-row.grand .t-lbl { color: var(--ink); }
        .t-row.grand .t-val { color: var(--accent); font-weight: 700; }
        .receipt-wrap { flex: 1; }
        .tape-edge { height: 10px; background: repeating-linear-gradient(90deg, var(--paper) 0 7px, var(--bg) 7px 14px); border: var(--border); }
        .tape-edge.top { border-bottom: none; }
        .tape-edge.bot { border-top: none; }
        .receipt-ta { display: block; width: 100%; font-family: 'DM Mono', monospace; font-size: 10px; line-height: 1.65; border: var(--border); border-top: none; border-bottom: none; background: var(--paper); color: var(--ink); padding: 10px 12px; white-space: pre-wrap; word-break: break-word; max-height: 280px; overflow-y: auto; height: auto; margin: 0; resize: none; }
        .btns { display: grid; grid-template-columns: 1fr 1fr; gap: 7px; }
        .btn { font-family: 'DM Mono', monospace; font-size: 10px; font-weight: 500; letter-spacing: 2px; text-transform: uppercase; padding: 9px 4px; border: var(--border); cursor: pointer; box-shadow: var(--sh-sm); transition: transform 0.1s, box-shadow 0.1s; background: var(--paper); color: var(--ink); }
        .btn:hover { transform: translate(-1px,-1px); box-shadow: 4px 4px 0 var(--ink); }
        .btn:active { transform: translate(2px,2px); box-shadow: 1px 1px 0 var(--ink); }
        .btn-print { background: var(--ink); color: var(--paper); }
        ::-webkit-scrollbar { width: 4px; }
        ::-webkit-scrollbar-thumb { background: rgba(20,20,20,0.25); }
    </style>
</head>
<body>
<%
    String tax      = (String) request.getAttribute("tax");
    String subtotal = (String) request.getAttribute("subtotal");
    String total    = (String) request.getAttribute("total");
    String ref      = (String) request.getAttribute("ref");
    int orderId     = (Integer) request.getAttribute("orderId");
    List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");

    StringBuilder receipt = new StringBuilder();
    receipt.append("  BILLING SYSTEM\n");
    receipt.append("  ----------------------------\n");
    receipt.append("  Ref   : ").append(ref).append("\n");
    receipt.append("  Order : #").append(orderId).append("\n");
    receipt.append("  ----------------------------\n\n");
    if (orderItems != null) {
        for (OrderItem item : orderItems) {
            String itemName = item.getName().length() > 14
                            ? item.getName().substring(0, 13) + "."
                            : item.getName();
            String lineAmt = String.format("Rs %,.2f", item.getLineTotal());
            receipt.append(String.format("  %-15s x%2d  %s%n", itemName, item.getQuantity(), lineAmt));
        }
    }
    receipt.append("\n  ----------------------------\n");
    receipt.append("  Subtotal :  ").append(subtotal).append("\n");
    receipt.append("  Tax (10%):  ").append(tax).append("\n");
    receipt.append("  ----------------------------\n");
    receipt.append("  Total    :  ").append(total).append("\n");
    receipt.append("  ----------------------------\n\n");
    receipt.append("  Thank you for your order!");
%>

<div class="header">
    <div class="logo">Billing<span>.</span>System</div>
    <div class="tagline">Food Billing &amp; Receipt</div>
</div>

<div class="layout">
    <div class="col left-col">
        <div class="col-head">Categories</div>
    </div>

    <div class="col">
        <div class="col-head">Select Dish</div>
        <div class="middle-col">
            <p>Order placed successfully</p>
            <div class="order-ref"><c:out value="${ref}"/></div>
            <p style="font-size:10px;">Order #<c:out value="${orderId}"/></p>
            <a class="new-order-btn" href="index.html">← New Order</a>
        </div>
    </div>

    <div class="col">
        <div class="col-head">Bill Summary</div>
        <div class="receipt-col">
            <div class="totals">
                <div class="t-row">
                    <div class="t-lbl">Tax</div>
                    <div class="t-val"><c:out value="${tax}"/></div>
                </div>
                <div class="t-row">
                    <div class="t-lbl">Subtotal</div>
                    <div class="t-val"><c:out value="${subtotal}"/></div>
                </div>
                <div class="t-row grand">
                    <div class="t-lbl">Total</div>
                    <div class="t-val"><c:out value="${total}"/></div>
                </div>
            </div>

            <div class="receipt-wrap">
                <div class="tape-edge top"></div>
                <%-- receipt text is server-generated plain text inside textarea, safe from XSS --%>
                <textarea class="receipt-ta" readonly><%= receipt.toString() %></textarea>
                <div class="tape-edge bot"></div>
            </div>

            <div class="btns">
                <button class="btn btn-print" onclick="window.print()">Print</button>
                <button class="btn" onclick="window.location='index.html'">Back</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
