Exercise 2 - Question 2
=======================

### Xiaoyu Liu, Yihao Zhang

Given the dataset consisting of 987 screening mammograms administered at
a hospital in Seattle from five radiologists, we are going to examine
the performance of the radiologists. The dataset includes 8 variables in
total. Radiologist is an indicator. There are two different outcome
variables called cancer and recall. The rest of the variables are risk
factors of mammograms, which are age, history, symptoms, menopause, and
density. Firstly, we need to find whether there are some radiologists
more clinically conservative. Secondly, try to find the important
clinical risk factors if radiologists need to make recall decisions.

First Question
--------------

To compare the conservative degree of different radiologists, we need to
see their recall decisions upon the same clinical case, which means that
all of them need to see the same patient theoretically. It is kind of
impossible for a patient to go to see 5 different radiologists. However,
we can find our best model for the recall decision and compare the
coefficients of the different radiologists. The larger the coefficient
of a radiologist is, the more conservative he/she is in recalling
patients. We tried four different models as listed below. We added
interaction terms in Model 2 ~ Model 4. For example, in Model 2, we
added the age\*menopause because older women have a larger possibility
to be menopaused and then a larger possibility to be recalled by the
hospital.

***Model 1:*** recall = *β*<sub>0</sub> + *β*<sub>1</sub>radiologist +
*β*<sub>2</sub>age + *β*<sub>3</sub>history + *β*<sub>4</sub>symptoms +
*β*<sub>5</sub>menopause + *β*<sub>6</sub>density

***Model 2:*** recall = *β*<sub>0</sub> + *β*<sub>1</sub>radiologist +
*β*<sub>2</sub>age + *β*<sub>3</sub>history + *β*<sub>4</sub>symptoms +
*β*<sub>5</sub>menopause + *β*<sub>6</sub>density +
*β*<sub>7</sub>age\*menopause

***Model 3:*** recall = *β*<sub>0</sub> + *β*<sub>1</sub>radiologist +
*β*<sub>2</sub>age + *β*<sub>3</sub>history + *β*<sub>4</sub>symptoms +
*β*<sub>5</sub>menopause + *β*<sub>6</sub>density +
*β*<sub>7</sub>age\*symptoms

***Model 4:*** recall = *β*<sub>0</sub> + *β*<sub>1</sub>radiologist +
*β*<sub>2</sub>age + *β*<sub>3</sub>history + *β*<sub>4</sub>symptoms +
*β*<sub>5</sub>menopause + *β*<sub>6</sub>density +
*β*<sub>7</sub>density\*symptoms

To find our best model, we calculated the average out-of-sample RMSE of
these four models for 100 different training/test sets. The results are
shown below. Model 4 has the lowest RMSE of these four models. The
reason why we add density\*symptoms interaction term in Model 4 is that
patients who have more cancer symptoms will also possibly have larger
breast densities, so they will be more likely to be recalled. Hence, we
use Model 4 to build our classification model.

<table>
<caption>Table 1: RMSE of different models</caption>
<thead>
<tr class="header">
<th style="text-align: center;">Model 1</th>
<th style="text-align: center;">Model 2</th>
<th style="text-align: center;">Model 3</th>
<th style="text-align: center;">Model 4</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: center;">0.353728</td>
<td style="text-align: center;">0.3555784</td>
<td style="text-align: center;">0.3554729</td>
<td style="text-align: center;">0.3536146</td>
</tr>
</tbody>
</table>

The coefficients of the model 4 see Table 2. Holding all risk factors
fixed, Radiologist89 has the largest coefficient and Radiologist34 has
the lowest coefficient towards recalling decision, supposing the missing
Radiologist13 as the benchmark. So according to our results, among these
five doctors, Radiologist89 is the most conservative one in recalling
patients while Radiologist34 is the least conservative one.

<table>
<caption>Table 2: Coefficients of different radiologists in Model 4</caption>
<thead>
<tr class="header">
<th style="text-align: center;">Radiologist34</th>
<th style="text-align: center;">Radiologist66</th>
<th style="text-align: center;">Radiologist89</th>
<th style="text-align: center;">Radiologist95</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: center;">-0.4888505</td>
<td style="text-align: center;">0.2147019</td>
<td style="text-align: center;">0.3167393</td>
<td style="text-align: center;">0.0346855</td>
</tr>
</tbody>
</table>

Second Question
---------------

In order to find out the important risk factors for the model of
recalling the patients, we build six different models for radiologists’
decision making. Then we randomly split the dataset into a training
dataset and a test dataset for 100 times and calculate the average
out-of-sample RMSE for each model. The model with the minimal average
RMSE is the best model and the explanatory variable except for recall
variable in that model is the important risk factor we want to find.

Model 1: ***cancer ~ recall***

Model 2: ***cancer ~ recall + age***

Model 3: ***cancer ~ recall + history***

Model 4: ***cancer ~ recall + symptoms***

Model 5: ***cancer ~ recall + menopause***

Model 6: ***cancer ~ recall + density***

The results of the average RMSE see Table 3. We can notice that there is
no difference if we add more variables to the model. Given our results
of models’ out-of-sample RMSE, the simplest model 1 has the best
performance on prediction. We believe that this is because when
radiologists decide to recall patients, they will consider all the risk
factors so there is nothing we can do to improve the model of regressing
cancer on recall decisions. To make sure Model 1 is the best, we compute
these six models’ AIC, listing in Table 4. That Model 1 has the lowest
AIC of -430.6 confirmed our conclusion that it is the best model. The
simpler the model is for prediction, sometimes the better.

<table>
<caption>Table 3: RMSE of different models</caption>
<thead>
<tr class="header">
<th style="text-align: center;">Model 1</th>
<th style="text-align: center;">Model 2</th>
<th style="text-align: center;">Model 3</th>
<th style="text-align: center;">Model 4</th>
<th style="text-align: center;">Model 5</th>
<th style="text-align: center;">Model 6</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: center;">0.3729068</td>
<td style="text-align: center;">0.524604</td>
<td style="text-align: center;">0.3763294</td>
<td style="text-align: center;">0.3953364</td>
<td style="text-align: center;">0.40184</td>
<td style="text-align: center;">0.469952</td>
</tr>
</tbody>
</table>

<table>
<caption>Table 3: AIC of different models</caption>
<thead>
<tr class="header">
<th style="text-align: center;">Model 1</th>
<th style="text-align: center;">Model 2</th>
<th style="text-align: center;">Model 3</th>
<th style="text-align: center;">Model 4</th>
<th style="text-align: center;">Model 5</th>
<th style="text-align: center;">Model 6</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: center;">-430.6</td>
<td style="text-align: center;">-429</td>
<td style="text-align: center;">-429.3</td>
<td style="text-align: center;">-428.6</td>
<td style="text-align: center;">-425.5</td>
<td style="text-align: center;">-430.5</td>
</tr>
</tbody>
</table>
