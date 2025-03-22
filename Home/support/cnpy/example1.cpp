/*
This is a stand alone raw data to NumPy array conversion c++ program, using the cnpy library. cnpy is found at: https://github.com/rogersce/cnpy
Development and implementation is on Linux Mint 21.2 in December 2024 - KJ

You don't need to follow the github site instructions for installing cnpy, just do this instead
Download the cnpy repo:
git clone https://github.com/rogersce/cnpy.git

I moved the downloaded cnpy folder to my ~/src folder
Save a copy of the example1.cpp found at ~/src/cnpy/ somewhere you will be able to find it if needed
Replace the example1.cpp found at ~/src/cnpy/ with this one

create a build folder:
mkdir -p ~/src/cnpy-build
cd src/cnpy-build
cmake ~/src/cnpy
make

Note: create a folder; ~/Documents/Godot/Projects/numpy_wave/art so data will have a place to be saved
Test run the program with:
~/src/cnpy-build/example1 192 2048 192 0
The output arr1_1.npy file is automatically loaded to ~/Documents/Godot/Projects/numpy_wave/art/arr1.npy
The program is set up to automatically append data to an existing file.  Change that to overwrite and existing file by changing the last line of code with:
    cnpy::npy_save(stringNmpyOut,&iteration_output[0],{dim_u,dim_z,dim_y,dim_x},"a");

You can save the example1 executable to /usr/local/bin to make it executable from any location
You can rename the executable as desired
*/

#include"cnpy.h"
#include<iostream>
#include<string>
#include<fstream>

#include<algorithm>                                                                                                    //for min and max values 

int main(int argc, char *argv[])
{
    if (argc != 5)
        {
        std::cerr << "Usage: " << argv[0] << " <num1> <num2> <num3> <num4>" << std::endl;
        return 1;
        }

    // Retrieve the user supplied dimensions of the vector that was stored as the raw_data_out.bin file
    const int dim_x = std::stoi(argv[1]);
    const int dim_y = std::stoi(argv[2]);
    const int dim_z = std::stoi(argv[3]);
    int append      = std::stoi(argv[4]);

    const int dim_u = 1;
    int flat_dim = dim_x*dim_y*dim_z;
    std::string stringDir;
    std::string stringNmpyOut;
    const std::string& home_ = std::getenv("HOME");

    //declare the vector, iteration_output, that will hold the simulation output
    std::vector<float> iteration_output(flat_dim);

    //read the simulation output raw data binary file and post an error message if the file can't be read
    stringDir = home_+"/scratch/runs/SST/simOutput/raw_data_out.bin";
    std::ifstream raw_data(stringDir, std::ios::binary);
    if (!raw_data.is_open())
        {
        std::cerr << "Error opening file!" << std::endl;
        return 1;
        }

    // copy the data (raw_data) into the iteration_output vector
    for (int x = 0; x < flat_dim; ++x) raw_data.read(reinterpret_cast<char*>(&iteration_output[x]), sizeof(float));

    raw_data.close();

    //parse the data (iteration_output[]) by applying a factor to every element
    for(int x=0; x<flat_dim; ++x) iteration_output[x] = iteration_output[x]*(-1.0);

    //std::cout << *std::min_element(iteration_output.begin(),iteration_output.end())<< " " << *std::max_element(iteration_output.begin(),iteration_output.end()) << "\n";         //for min and max values

    //save iteration_output[] to file as a NumPy array.  Note: The last arguement in the cnpy::npy_save() instruction is either "w" to overwrite or "a" to append.  The 4 lines of code below send "w" to storage in the numpy_wave Project and "a" to storage in the anime_wave Project
    //stringNmpyOut = home_+"/scratch/runs/SST/simOutput/savedNPY/arr1.npy";
    stringNmpyOut = home_+"/Documents/Godot/Projects/numpy_wave/art/arr_1.npy";
    cnpy::npy_save(stringNmpyOut,&iteration_output[0],{dim_u,dim_z,dim_y,dim_x},"w");
    stringNmpyOut = home_+"/Documents/Godot/Projects/anime_wave/art/arr_4d.npy";
    if(append == 1) cnpy::npy_save(stringNmpyOut,&iteration_output[0],{dim_u,dim_z,dim_y,dim_x},"a");
}
