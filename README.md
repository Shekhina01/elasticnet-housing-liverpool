# 🏡 Predicting Liverpool Housing Prices Using Elastic Net Regression

This project applies **Elastic Net Regression** to predict housing prices in Liverpool using socioeconomic and demographic data. Developed during my MSc in Data Science at the University of Leeds, it showcases my ability to apply advanced statistical modelling to real-world problems in urban analytics and public policy.

---

## 🎯 Objectives

- Build a predictive model using Elastic Net (a combination of Lasso and Ridge)
- Identify key drivers of house prices in Liverpool
- Demonstrate advanced data science techniques in R

---

## 📊 Dataset & Features

**Observations:** 2,211  
**Variables:**  
- `Price`: Sale price  
- `Beds`: Bedrooms  
- `Gs_area`: Green space area (%)  
- `Unmplyd`, `U25`, `O65`: Age group percentages and unemployment rates

---

## 🔧 Methods Used

- Log transformation of skewed predictors
- Data partitioning (80% training / 20% testing)
- Standardisation (scaling and centering)
- Hyperparameter tuning (`alpha`, `lambda`)
- 10-fold Cross Validation using `caret`
- Model evaluation using **RMSE** and **R²**

---

## 🖥️ Tools & Libraries

- R, `caret`, `glmnet`, `ggplot2`, `dplyr`, `sf`
- RMarkdown for reproducible reporting

---

## 📁 Project Structure

| Folder/File         | Description                           |
|---------------------|----------------------------------------|
| `FINAL CODE.R`      | Elastic Net modelling code in R        |
| `201740454.pdf`     | Full academic report                   |
| `assign_data.RData` | Data file (if permitted to share)      |

---

## 📈 Results

- **RMSE:** 0.384  
- **R²:** 0.637  
- Most influential variables: `Beds`, `Unmplyd`

---

## ✍️ Author

**Shekhina Mary Jebaraj**  
📍 Leeds, UK | MSc Data Science, University of Leeds  
🔗 [LinkedIn](https://linkedin.com/in/shekhinamaryjebaraj)  
📧 shekhinamaryjebaraj@gmail.com

---

## 📬 Contact & Citation

Feel free to reach out for collaboration or questions.  
If referencing this work, please cite:

> Jebaraj, S.M. (2025). *Elastic Net Model for Liverpool Housing Market*, MSc Data Science Project, University of Leeds.
