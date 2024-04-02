import re

def find_names(names, match_words):
  """Finds all names in the list that match the given words.

  Args:
    names: A list of strings.
    match_words: A list of strings.

  Returns:
    A list of strings that match the given words.
  """
  matched_names = []
  for name in names:
    for match_word in match_words:
      if re.match(match_word, name, re.IGNORECASE):
        matched_names.append(name)
        break

  return matched_names

names = ["Aakash Wilfred", "Abhishek Ashok Lohade", "Adarsh Gupta", "Adarsh Singh", "Aditya", "Aman Battan", "Amit Kamble", "Anil Kumar Yadav", "Ankit Soni", "Anmol Munje", "Anshit Singh", "Anubhav Singh", "Anurag Garg", "Anurag Srivastava", "Arunkumar Ramjeet Pal", "Atharva Joshi", "Avani Pandya", "Ayan Madaan", "Ayush Bhatnagar", "Bhoomika Mewada", "Chinmay Anilkumar Jadhav", "Dakshay Arvind Mhatre", "Deepak Labh", "Dhaval Prajapati", "Dhruv Himanshu Bhagadia", "Gaurav Raizada", "Gourav Chopra", "Harsh Shrivastava", "Harsh Thakkar", "Harsh Vardhan Jain", "Hemant Karanjkar", "Hrishikesh Nitin Deshpande", "Jay Gupta", "Jerin Jacob", "Jitesh Agrawal", "Jyosana Ashok Jadhav", "Jyoti Hooda", "Keshav Gupta", "Khyati Tiwari", "Lokvishrutt Bishnoi", "Madhav Agarwal", "Mahesh Laxman Matkar", "Meet Dixit", "Monu Kumar Gupta", "Mousumi Kundu", "Mukhesh Pugalendhi Sudha", "Nabeel Ahmad", "Nishant Mittal", "Omkar Alhad Kulkarni", "Piyush Vijay", "Prateek Jaiswal", "Prateek Varshney", "Pratik Sunil Patil", "Prinkesh Sharma", "Purushottam", "R. Shashant", "Rahul Kumar", "Rahul Kumar Singh", "Rajib Ranjan Borah", "Ramdas Gaikar", "Ravi Shukla", "Sameer Kumar", "Sanghani Kaushik Chimanbhai", "Sanjay Nathuram Pawar", "Sankalp Malpani", "Saurabh Jain", "Singh Jyotsanakumari", "Soumy Prateek", "Sunidhi Pandey", "Sunny Jeswani", "Suraj Mathur", "Surajkumar Kanaujiya", "Surbhi Bhati", "Surya Kant Garg", "Sushmita", "Swetha Sreekumar Nair", "Thuraka Veda Samhith Reddy", "Uday Gupta", "Ujjwal Prahladka", "Vatsal Khandelwal", "Vedant Bang", "Vishal Raval", "VishwarajSinh Rana"]
match_words = ["gaurav", "harsh", "atharva"]

matched_names = find_names(names, match_words)

print(matched_names)

