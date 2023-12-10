import { Injectable } from '@nestjs/common';
import { CreateServiceDto } from './dto/create-service.dto';
import { UpdateServiceDto } from './dto/update-service.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Service } from './entities/service.entity';
import { Repository } from 'typeorm';
import { VehiclesService } from 'src/vehicles/vehicles.service';

@Injectable()
export class ServiceService {
  constructor(
    @InjectRepository(Service)
    private serviceRepository: Repository<Service>,
    private readonly vehicleService: VehiclesService,
  ) {}

  async create(createServiceDto: CreateServiceDto) {
    const vehicle = await this.vehicleService.findOneByID(
      createServiceDto.vehicleID,
    ); // It will throw error if user not found
    const serviceDTO = {
      title: createServiceDto.title,
      description: createServiceDto.description,
      type: createServiceDto.type,
      vehicles: [vehicle],
    };
    const newService = await this.serviceRepository.save(serviceDTO);
    return newService;
  }

  async findAll(): Promise<Service[]> {
    return await this.serviceRepository.find();
  }

  findOne(id: number) {
    return `This action returns a #${id} service`;
  }

  update(id: number, updateServiceDto: UpdateServiceDto) {
    return `This action updates a #${id} service`;
  }

  async remove(id: number) {
    return await this.serviceRepository.delete({ id });
  }
}
