# SJTU-EE215
The class project of EE215 in SJTU, named Engineering Problem Modeling and Simulation. The first project is about Genetic Algorithm. The second and third method is simulating a engineering problem with Monte Carlo method and Markov chain.

## Project 1: Calibration problem of a measuring device in mass production

This project is based on the input and output characteristics of a temperature sensor inside a product. Since the input-output characteristics of the core sensor are obviously nonlinear and the individual differences are relatively large, a method of calibration process is designed for the device by using **interpolation**, **fitting** and **heuristic search** (**Genetic Algorithm**) methods and establishing a relationship curve model by means of MATLAB. Suitable for large-scale and high-efficiency manufacturing.

## Project 2: Reliability Evaluation and System Optimization of Synchronous Clock Mechanism in a Multi-Node Sonar System

This project is based on a synchronous clock mechanism in a multi-node sonar system. Since every component in the electronic system has the possibility of failure, and whether the entire system functions properly depends on whether the component is functioning properly. Each component has its own probability of failure under different conditions and different types of faults. There are many possibilities for the reliability of the entire system. Using the **Monte Carlo** method and the **Markov chain**, MATLAB is used to simulate the operation of the system, so that the reliability of the entire system can be evaluated.

## Project 3: Reliability evaluation of a RS485 multi-machine communication system

This project uses an RS485 multi-machine communication system as the research object. There are multiple subsystems in a communication system, each of which is composed of multiple components. Each component has the potential to fail, and different failure conditions can lead to different types of system failure.  However, components can be repaired manually after failure, and some measures can be taken to reduce system failure. There are many possibilities for the working state of the whole system, and there is great uncertainty. Using the **Monte Carlo** method and the **Markov chain**, MATLAB is used to simulate the system operation and manual repair, so that the overall system's fault frequency, repair frequency and reliability can be evaluated.

Measure 1: introducing the Watchdog mechanism into the microprocessor.

Measure 2: prevent interface board failures from blocking the bus.

Measure 3: Hot standby of the host.