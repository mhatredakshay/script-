import re

def find_names(names, match_words):
  """Finds all names in the list that match the given words, case-insensitive.

  Args:
    names: A list of strings.
    match_words: A list of strings.

  Returns:
    A list of strings that match the given words.
  """
  matched_names = []
  for name in names:
    name_parts = name.split('.')  # Split the name by dot
    if len(name_parts) == 2:  # Ensure there's exactly one dot
      first_name, last_initial = name_parts
      first_name = first_name.strip()
      last_initial = last_initial.strip()
      for match_word in match_words:
        first_word = match_word.split()[0]
        last_word = match_word.split()[-1]
        if first_name.lower() == first_word.lower() and last_initial.lower() == last_word[0].lower():
          matched_names.append(name)
          break

  return matched_names

names_str = "atharva.j, harsh.t, jitesh.a, jyotsana.s, gaurav.r, mousumi.k, vrinda.g, kaushik.s, aditya.v, omkar.k, sushmita, madhav.a, sunidhi.p, taksh.k, shree.p"
names_list = [name.strip() for name in names_str.split(',')]

match_words = ["Aakash Wilfred", "Abhishek Ashok Lohade", "Adarsh Gupta", "Adarsh Singh", "Aditya", "Aman Battan", "Amit Kamble", "Anil Kumar Yadav", "Ankit Soni", "Anmol Munje", "Anshit Singh", "Anubhav Singh", "Anurag Garg", "Anurag Srivastava", "Arunkumar Ramjeet Pal", "Atharva Joshi", "Avani Pandya", "Ayan Madaan", "Ayush Bhatnagar", "Bhoomika Mewada", "Chinmay Anilkumar Jadhav", "Dakshay Arvind Mhatre", "Deepak Labh", "Dhaval Prajapati", "Dhruv Himanshu Bhagadia", "Gaurav Raizada", "Gourav Chopra", "Harsh Shrivastava", "Harsh Thakkar", "Harsh Vardhan Jain", "Hemant Karanjkar", "Hrishikesh Nitin Deshpande", "Jay Gupta", "Jerin Jacob", "Jitesh Agrawal", "Jyosana S", "Jyoti Hooda", "Keshav Gupta", "Khyati Tiwari", "Lokvishrutt Bishnoi", "Madhav Agarwal", "Mahesh Laxman Matkar", "Meet Dixit", "Monu Kumar Gupta", "Mousumi Kundu", "Mukhesh Pugalendhi Sudha", "Nabeel Ahmad", "Nishant Mittal", "Omkar Alhad Kulkarni", "Piyush Vijay", "Prateek Jaiswal", "Prateek Varshney", "Pratik Sunil Patil", "Prinkesh Sharma", "Purushottam", "R. Shashant", "Rahul Kumar", "Rahul Kumar Singh", "Rajib Ranjan Borah", "Ramdas Gaikar", "Ravi Shukla", "Sameer Kumar", "Kaushik Chimanbhai Sanghani", "Sanjay Nathuram Pawar", "Sankalp Malpani", "Saurabh Jain", "Jyotsanakumari Singh", "Soumy Prateek", "Sunidhi Pandey", "Sunny Jeswani", "Suraj Mathur", "Surajkumar Kanaujiya", "Surbhi Singh", "Surya Kant Garg", "Sushmita", "Swetha Sreekumar Nair", "Thuraka Veda Samhith Reddy", "Uday Gupta", "Ujjwal Prahladka", "Vatsal Khandelwal", "Vedant Bang", "Vishal Raval", "VishwarajSinh Rana"]

matched_names = find_names(names_list, match_words)

print(matched_names)
