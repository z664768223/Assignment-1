**Assignment 3**

**Problem 2**

**Xiaoyu Liu, Yihao Zhang**

**1. Why can’t I just get data from a few different cities and run the
regression of “Crime” on “Police” to understand how more cops in the
streets affect crime?**

Because there is not a clear relationship between the police and the
crime. In this case, we could not clarify the police and crime which is
the cause, and which is the effect. For areas which increase its amount
of police in response to recent increase crime rate, **crime** is the
cause and it affect **Police**. And Under this scenario, running
regressions of “Crime” on “Police” will but the dependence and
independence variables in the opposite positions which will turn the
model to be meaningless.

**2. How were the researchers from UPenn able to isolate this effect?
Discuss their result in the “Table 2”.**

The point here is to isolate the proportion of **crime** which will
affect **Policy** by only consider the situation where the city
increases its amount of police for reasons unrelated to crime. And this
will keep the **police** as the cause and **crime** as the effect.

Then, the researchers at UPenn found that the terrorism alert system can
indicate whether the city increases its amount of crime-unrelated
police. And Washington, D.C., is likely to be a terrorism target, when
the terror alert level goes to orange, then extra police are put on the
Mall and other parts of Washington to protect against terrorists.

Subsequently, they collected data of daily total crimes in D.C. as the
dependence variable and performed analysis using two different models:

-   Performed regression analysis of daily total crimes on one single
    dummy variable **High Alert** indicates whether the alert level in
    D.C. goes orange or beyond. And from table 2, we can see the
    coefficient of **High Alert** is negative which tells on high alert
    days, crime rate decreases. (The coefficient is significant if we
    compare to the 5% confidence interval.)
-   Performed regression analysis of daily total crimes on a dummy
    variable **High Alert** plus a new variable **midday ridership**
    which indicates the ridership levels on the Metro system. And from
    table 2, we can the effect of **High Alert** is still negative but
    slightly decreased and the increase in **midday ridership** will
    cause an increase in crime rate. (Both coefficients are significant
    if we compare to the 5% and 1% confidence intervals.) This is
    because the ridership level can indicate the potential victims on
    the street and the more victims on street, criminals are more likely
    to commit crimes.

But these two analyses are not strong enough to prove theory, that is
more police leads to less crime. Because it is possible for criminals to
be afraid of terrorists and decide stay at home during high alert days.

**3. Why did they have to control for Metro ridership? What was that
trying to capture?**

If people were not out and about during the high alert days, there would
be fewer potential victims and fewer opportunities for crime and hence
less crime (not due to more police). Metro ridership can identify the
victims on the streets and have control for Metro ridership will isolate
the portion negative effect from **High Alert** on **crime** which is
due the decrease in potential victims. Doing this can help researchers
capture the real effect of increase in police on crime rate.

**4. Can you describe the model being estimated in table 4? What is the
conclusion?**

From table 4, we can tell that the researchers refined the analysis by
adding interaction terms between **location variables** and **High
Alert**. This will help them to verify whether the effect of high alert
days on crime changes or remain the same across different areas in D.C.

From the result, we can see District 1 is the only area that high alert
days have significant effect on crime rate. This is a reasonable result
since District 1 is the main targets of potential terrorists and the
police are more likely to be deployed there during high alert days. The
effect of high alert days on crime rate in other districts is not
significant (equals to 0). Based on the result, we cant reject the
hypothesis that the coefficient of **High Alert \* Other District**
equals to 0 at 5% level.
