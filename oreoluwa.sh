#!/usr/bin/bash

echo "Hello! I'm a Cloud Engineering student at AltSchool Africa"

FirstName=Aishat
MiddleName=Oreoluwa
LastName=Adebayo

full-name() {
    echo -e "\nMy name is $LastName, $FirstName $MiddleName. "
}

bio() {
    echo "I'm a final-year Food Science student at Obafemi Awolowo University. I am currently dedicating myself to honing DevOps skills in Linux, Python, AWS, etc. and overcoming the challenges of time constraints with resilience and focus. My passion extends beyond technology. I love collecting cactus and succulent plants. I'm also deeply passionate about environmental responsibility and community well-being. I actively educate those around me on the importance of proper waste disposal, reducing plastic use, and nurturing plants. Through these efforts, I aim to make a positive impact, encouraging others to adopt sustainable practices and contribute to a healthier planet."
}

years-in-tech() {
    echo -e "\nI was introduced to Python programming in my sophomore year of uni, but I never applied it. It would only be right to say I'm new to it all and this is my $1st year in tech."
}

goal() {
    echo -e "\nMy goal is to become a Cloud Computing and DevOps professional, and earn industry-recognized certifications."
}

dream-job() {
    echo "Driven by curiosity about how the company handles vast amounts of data across its platforms, my dream job is to become a Cloud Solutions Architect at Google LLC."
}

#Function call
full-name
bio
years-in-tech "1"
goal
dream-job
