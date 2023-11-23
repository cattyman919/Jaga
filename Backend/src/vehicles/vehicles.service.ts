import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateVehicleDto } from './dto/create-vehicle.dto';
import { UpdateVehicleDto } from './dto/update-vehicle.dto';
import { InjectRepository } from '@nestjs/typeorm';

import { ObjectId, Repository, SelectQueryBuilder } from 'typeorm';
import { Vehicle } from './entities/vehicle.entity';
import { UserService } from 'src/user/user.service';

@Injectable()
export class VehiclesService {
  constructor(
    @InjectRepository(Vehicle)
    private vehiclesRepository: Repository<Vehicle>,
    private readonly userService: UserService,
  ) { }

  async create(createVehicleDto: CreateVehicleDto) {
    // Find if user Id is valid
    await this.userService.findOneById(createVehicleDto.userID); // It will throw error if user not found

    const newVehicle = await this.vehiclesRepository.create(createVehicleDto);
    await this.vehiclesRepository.save(newVehicle);
    return newVehicle;
  }

  async findAll() {
    return await this.vehiclesRepository.find();
  }

  async findOneByName(name: string): Promise<Vehicle> {
    return await this.vehiclesRepository.findOneBy({ name });
  }

  async findOneVehicleByUserID(userID: number): Promise<Vehicle> {
    return await this.vehiclesRepository.findOneBy({ userID });
  }

  async findOneByID(id: number) {
    const vehicle = await this.vehiclesRepository.findOneBy({ id });
    if (vehicle) return vehicle
    throw new HttpException(
      'Vehicle with this id does not exist',
      HttpStatus.NOT_FOUND,
    );
  }

  async update(id: number, updateVehicleDto: UpdateVehicleDto) {
    const { kilometres, name, type, years } = updateVehicleDto;

    if (kilometres == null && name == null && type == null && years == null) {
      throw new HttpException("Body is empty!", HttpStatus.BAD_REQUEST);
    }

    await this.findOneByID(id);
    try {
      await this.vehiclesRepository.update({ id }, updateVehicleDto);
    } catch (error) {
      throw error;
    }

    return await this.findOneByID(id);
  }

  async remove(id: number) {
    await this.findOneByID(id);
    try {
      await this.vehiclesRepository.delete({ id });
    } catch (error) {
      throw error;
    }
    return {
      "message": `Vehicle with id ${id} has been deleted`,
      "status": "SUCCESS"
    };
  }
}
