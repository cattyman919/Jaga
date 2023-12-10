import { Module } from '@nestjs/common';
import { ServiceService } from './service.service';
import { ServiceController } from './service.controller';
import { Service } from './entities/service.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VehiclesModule } from 'src/vehicles/vehicles.module';

@Module({
  imports: [TypeOrmModule.forFeature([Service]), VehiclesModule],
  controllers: [ServiceController],
  providers: [ServiceService],
})
export class ServiceModule {}
