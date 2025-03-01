/*

Download the cnpy repo:
git clone https://github.com/rogersce/cnpy.git

create a build folder:
mkdir -r ~/src/cnpy-build
cmake ~/src/cnpy
make

Make the example1 file that is generated executable
Create a numpy_wave Project by copying 

run the program with:
~/src/cnpy-build/example1 192 2048 192

You can save the example1 executable to /usr/local/bin to make it executable from any location
You can rename the executable as desired
*/

#include"cnpy.h"
#include<iostream>
#include<string>
#include <fstream>

int main(int argc, char *argv[])
{
    if (argc != 4)
        {
        std::cerr << "Usage: " << argv[0] << " <num1> <num2> <num3>" << std::endl;
        return 1;
        }

    const int dim_x = std::stoi(argv[1]);
    const int dim_y = std::stoi(argv[2]);
    const int dim_z = std::stoi(argv[3]);

    int flat_dim = dim_x*dim_y*dim_z;

    std::string stringDir;
    std::string stringDirRemove;
    std::string stringDirCreate;
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

    //parse the data by applying a factor to every element

    //for(int x=0; x<flat_dim; ++x) iteration_output[x] = iteration_output[x]*(-1.0/5.0);

    //save it to file
    stringNmpyOut = home_+"/Documents/Godot/Projects/numpy_wave/addons/volume_layered_shader/art/arr1.npy";
    cnpy::npy_save(stringNmpyOut,&iteration_output[0],{dim_z,dim_y,dim_x},"w");

/*
    //load it into a new array
    cnpy::NpyArray arr = cnpy::npy_load("arr1.npy");
    std::complex<double>* loaded_data = arr.data<std::complex<double>>();
    
    //make sure the loaded data matches the saved data
    assert(arr.word_size == sizeof(std::complex<double>));
    assert(arr.shape.size() == 3 && arr.shape[0] == Nz && arr.shape[1] == Ny && arr.shape[2] == Nx);
    for(int i = 0; i < Nx*Ny*Nz;i++) assert(data[i] == loaded_data[i]);

    //append the same data to file
    //npy array on file now has shape (Nz+Nz,Ny,Nx)
    cnpy::npy_save("arr1.npy",&data[0],{Nz,Ny,Nx},"a");

    //now write to an npz file
    //non-array variables are treated as 1D arrays with 1 element
    double myVar1 = 1.2;
    char myVar2 = 'a';
    cnpy::npz_save("out.npz","myVar1",&myVar1,{1},"w"); //"w" overwrites any existing file
    cnpy::npz_save("out.npz","myVar2",&myVar2,{1},"a"); //"a" appends to the file we created above
    cnpy::npz_save("out.npz","arr1",&data[0],{Nz,Ny,Nx},"a"); //"a" appends to the file we created above

    //load a single var from the npz file
    cnpy::NpyArray arr2 = cnpy::npz_load("out.npz","arr1");

    //load the entire npz file
    cnpy::npz_t my_npz = cnpy::npz_load("out.npz");
    
    //check that the loaded myVar1 matches myVar1
    cnpy::NpyArray arr_mv1 = my_npz["myVar1"];
    double* mv1 = arr_mv1.data<double>();
    assert(arr_mv1.shape.size() == 1 && arr_mv1.shape[0] == 1);
    assert(mv1[0] == myVar1);
*/
}
