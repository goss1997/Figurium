
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .review-form {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .review-form h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .form-group textarea {
            resize: vertical;
        }

        .rating {
            display: flex;
            justify-content: space-between;
            width: 200px;
        }

        .rating input {
            display: none;
        }

        .rating label {
            font-size: 24px;
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s ease-in-out;
        }

        .rating input:checked ~ label,
        .rating input:hover ~ label {
            color: #f5c518;
        }

        .submit-btn {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
        }

        .submit-btn:hover {
            background-color: #0056b3;
        }

    </style>
</head>
<body>
<div class="review-form">
    <h2>상품 후기 작성</h2>
    <form id="reviewForm">
        <div class="form-group">
            <label for="reviewTitle">후기 제목</label>
            <input type="text" id="reviewTitle" name="reviewTitle" placeholder="후기 제목을 입력하세요" required>
        </div>
        <div class="form-group">
            <label for="reviewContent">후기 내용</label>
            <textarea id="reviewContent" name="reviewContent" rows="5" placeholder="후기를 작성하세요" required></textarea>
        </div>
        <div class="form-group">
            <label for="reviewRating">평점</label>
            <div class="rating">
                <input type="radio" id="star5" name="rating" value="5">
                <label for="star5" title="5점">★</label>
                <input type="radio" id="star4" name="rating" value="4">
                <label for="star4" title="4점">★</label>
                <input type="radio" id="star3" name="rating" value="3">
                <label for="star3" title="3점">★</label>
                <input type="radio" id="star2" name="rating" value="2">
                <label for="star2" title="2점">★</label>
                <input type="radio" id="star1" name="rating" value="1">
                <label for="star1" title="1점">★</label>
            </div>
        </div>
        <div class="form-group">
            <button type="submit" class="submit-btn">후기 제출</button>
        </div>
    </form>
</div>

</body>
</html>
