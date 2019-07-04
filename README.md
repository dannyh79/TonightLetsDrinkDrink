# 今夜想買醉
- 聚餐應酬怕喝掛，那就先來估一下
- 估計在一段時間後的五種「醉況」所對應的酒的份量
- 網頁支援手機視窗，滑手機眼睛不痛痛
---
## 介紹
- 使用者在申辦帳號後，可以使用「選一種酒」或者是「自製調酒」來估計五種醉況
- 依照使用者輸入的資訊來估計在一段時間後，到達五種醉況所對應的酒的份量
- 醉況按鈕點選後會顯示行為特徵及影響來供使用者作參考，提倡理性飲酒

## Demo
[今夜想買醉](https://tonight-lets-drink-drink.herokuapp.com/)

試用帳號：
- Email - `(111@111.com)`
- Password - `(111111)`

## Getting Started
> Ruby 版本: 2.6.0

> Rails 版本: 5.2.3

### 初始化
安裝 PG （安裝步驟[參考資料](https://www.postgresql.org/download/)）後，於終端機中：
1. `$ git clone https://github.com/dannyh79/TonightLetsDrinkDrink.git`
2. `$ cd tonightLetsDrinkDrink`
3. `$ bundle install`
4. `$ rails db:create`
5. `$ rails db:migrate` 
6. `$ rails db:seed`
7. `$ rails server`
8. 於瀏覽器網址列輸入`localhost:3000/`後按 enter

### 「忘記密碼」服務
1. 申辦 [Mailgun](https://www.mailgun.com/) 的寄信服務
2. 將帳號密碼加入`config/application.yml`中。格式請參考`config/application.yml.example`

## ER Diagram
![ERD](https://gist.github.com/dannyh79/830e1f1fca212b71e0fa288431abc7b5/raw/5b3e3aca4949096c978a6c6134db33c73e0560ec/ERD%252006.24.png)

## Test Suite
欲執行專案內的測試，請於終端機中：
1. 進入專案的資料夾，如`$ cd tonightLetsDrinkDrink`
2. `$ rpesc`

## 作者
- [Eva Yang](https://github.com/evayangms)
- [MK](https://github.com/mkx777)
- [Chao Wu](https://github.com/chaochaowu)
- [Danny Cheng-Hsuan Han](https://github.com/dannyh79)