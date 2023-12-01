import { Module } from '@nestjs/common';
import { VehicleModelsService } from './vehicle_models.service';
import { VehicleModelsController } from './vehicle_models.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VehicleModel } from './entities/vehicle_model.entity';

@Module({
  imports: [TypeOrmModule.forFeature([VehicleModel])],
  controllers: [VehicleModelsController],
  providers: [VehicleModelsService],
})
export class VehicleModelsModule { }
