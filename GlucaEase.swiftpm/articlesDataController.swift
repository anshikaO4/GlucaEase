import Foundation

class articlesDataController: ObservableObject {
    @Published var articles: [Article] = []
    
    init() {
       
        articles = [
            Article(title: " Automated Insulins", description: "Study Shows Open-Source Automated Insulin Delivery is a Safe and Effective Option", image: "insulin", content: """

First-of-Its-Kind Study Compares Open-Source Automated Insulin Delivery to Sensor-Augmented Pump Therapy 

Results from the CREATE Trial demonstrated open-source automated insulin delivery (AID) systems are a safe and effective therapy for people with type 1 diabetes. Findings from the randomized controlled trial (RCT) comparing open-source AID to sensor-augmented pump therapy (SAPT) were presented today at the 82nd Scientific Sessions of the American Diabetes Association® (ADA).

Open-source AID systems were developed to reduce the burden of living with diabetes by combining an insulin pump, continuous glucose monitor (CGM), and an algorithm that automatically adjusts insulin delivery every five minutes to keep glucose levels in target range. The technology was developed by people with diabetes and shared openly, commonly referred to as open-source, so that others could evaluate the system and choose to use it themselves. These open-source systems were available for years before commercial AID systems and are used by people with type 1 diabetes worldwide.

The CREATE Trial is the first randomized controlled trial to evaluate the safety and efficacy of the most commonly used open-source AID system. The study compared open-source AID, using the OpenAPS algorithm from a version of AndroidAPS implemented in a smartphone with the DANA-i™ insulin pump and Dexcom G6® CGM, to SAPT. A diverse population of patients, many of whom had little or no experience with AID, were recruited to a 24-week, multi-center RCT, which included children (7–15 years) and adults (16–70 years), to examine efficacy and safety of open-source AID.
"""),
            
            
            Article(title: "Fruits for Diabetes", description: "When you eat carbs, your body turns it into sugar, directly impacting your blood sugar levels.", image: "fruits", content: """

What are the best fruit choices?
The best choice is fresh fruit, according to the ADA. They also recommend frozen or canned fruit that does not have added sugars. Check the food labels for added sugar, and be aware that sugar has many different names on labels. This includes cane sugar, invert sugar, corn sweetener, dextran, and high fructose corn syrup.

Recommended fresh fruits include:
apple
blueberry
cherry
grapefruit
grape
orange
peach
pear
plum

A 2013 studyTrusted Source published in the British Medical Journal concluded that the consumption of whole fruits, apples, blueberries, and grapes is significantly associated with a lower risk of developing type 2 diabetes.
What is the correct portion size?
The Mayo Clinic indicates that a serving size depends on the fruit’s carb content. One serving of fruit contains about 15 grams of carbs.
Fruit servings that have about 15 grams of carbs include:

1 small piece of fresh fruit (4 ounces)
½ cup of canned or frozen fruit (no sugar added)
2 teaspoons of dry fruit such as dried cherries or raisins
Other serving sizes that have about 15 grams of carbs include:
½ medium apple
1 small banana
1 cup cubed cantaloupe or honeydew melon
1 cup blackberries
¾ cup blueberries
17 small grapes
1 cup raspberries
1¼ cup whole strawberries
"""),
            
            Article(title: "Gestational diabetes", description: "Glucokinase regulatory protein (GCKR) has been associated with GDM in studies", image: "gestational", content: """

Background
Gestational diabetes mellitus (GDM) is one of the most common complications of pregnancy and is highly associated with adverse perinatal outcomes and long-term health problems for the mother and offspring. However, there are respective limitations in the pharmacological strategies for the current treatment of GDM. Glucokinase regulatory protein (GCKR) has been associated with GDM in observational studies and animal experiments and thus represents a potential drug target of interest for investigation.

Methods
We applied two-sample Mendelian randomization (MR) and colocalization analysis using summary-level data from genome-wide association studies of GCKR and GDM. Two-step MR was used to explore the mediating effects of several metabolic factors on the association. We also applied MR to explore the associations of GCKR levels with GDM-related outcomes. Finally, we performed a phenome-wide association study (PheWAS) to query the potential effects of altered GCKR levels across multiple health categories.

Results
We found a significant association between elevated GCKR levels and GDM (OR = 3.466, 95% CI = 2.401–5.002, p = 3.16 × 10−11), also supported by the colocalization analysis ([Pcoloc] = 0.997). The estimates were replicated in an independent study (OR = 2.640, 95% CI = 1.983–3.513, p = 2.84 × 10−11, Pcoloc = 0.983). Elevated GCKR levels were also associated with higher risk of type 2 diabetes (OR = 2.183, 95% CI = 1.846–2.581, p = 6.53 × 10−20). Two-step MR suggested that fasting glucose, fasting insulin, and triglycerides partly mediated the causal relationship. PheWAS found that targeting GCKR may improve renal function and glucose homeostasis but cause dyslipidemia and uric acid abnormalities.

Conclusions
This study provided novel evidence that circulating GCKR levels are causally implicated in GDM and related complications, suggesting that it may be a promising target for treatment.
""")
        ]
    }
}

