import { Injectable } from '@nestjs/common';
import { CreateVehicleModelDto } from './dto/create-vehicle_model.dto';
import { UpdateVehicleModelDto } from './dto/update-vehicle_model.dto';
import { VehicleModel } from './entities/vehicle_model.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class VehicleModelsService {
  constructor(
    @InjectRepository(VehicleModel)
    private vehicleModelsRepository: Repository<VehicleModel>,
  ) { }

  async create(createVehicleModelDto: CreateVehicleModelDto) {
    const newVehicleModel = await this.vehicleModelsRepository.create(createVehicleModelDto);
    await this.vehicleModelsRepository.save(newVehicleModel);
    return newVehicleModel;
  }

  async findAll() {
    return await this.vehicleModelsRepository.find();
  }

  async findOneByName(name: string): Promise<VehicleModel> {
    return await this.vehicleModelsRepository.findOneBy({ model_name: name });
  }

  findOne(id: number) {
    return `This action returns a #${id} vehicleModel`;
  }

  update(id: number, updateVehicleModelDto: UpdateVehicleModelDto) {
    return `This action updates a #${id} vehicleModel`;
  }

  remove(id: number) {
    return `This action removes a #${id} vehicleModel`;
  }
}
