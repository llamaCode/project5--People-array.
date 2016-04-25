# people -- manipulate an array of objects.

Create a **```Person```** class and make an array containing at least eight instances.  
Each instance of the ```Person``` object should have the folowing properties:
- w (weight, in pounds)
- h (height, in inches)
- name (```String```)
- color (r,g,b)  

Include at least two different constructors, 
and a **```show()```** method 
to display an image of the person
(using a rectangle proportional to w and h) 
plus a head and legs.  
Display the name, width, and height underneath each image:
- Height should be shown in feet and inches.
- Width represents pounds (or "#")
<IMG SRC=http://www.suffolk.li/cst112/61cst112/students/people3.png ALIGN=RIGHT WIDTH=300 >

###ARRAY:
Create an array of **```Person```** objects,  
and main-program functions to manipulate them.

Perform the following operations when a button is clicked *(or key pressed)*:
- **Reset** -- Re-initialize all people (with random values for w and h).   
- **Tallest** -- Move the tallest to the end.
- **Fattest** -- Move the widest to the end.  
    -- _**NOTE:**  After moving an element to the end of the array, be sure to replace it with whatever was previously at the end (i.e. "**swap**" the elements)_.

<HR> 
###DISPLAY:
Display the entire array, in order, near the bottom of the screen.  

Also show a set of clouds moving slowly across the sky.  
When clouds reach the right side, a new set of clouds begins at a random height on the left.  
Each set has a random number of clouds, with each cloud smaller and lower in the sky. 

Features of the final program are illustrated by sample programs *(which do not use arrays)*:
- people1.pde 
- people2.pde  


