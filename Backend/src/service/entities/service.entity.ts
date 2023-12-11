import { Vehicle } from 'src/vehicles/entities/vehicle.entity';
import {
  Column,
  Entity,
  JoinColumn,
  ManyToMany,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('service')
export class Service {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  title: string;

  @Column({ nullable: false })
  description: string;

  @Column({ enum: ['overdue', 'upcoming'], type: 'enum', nullable: false })
  type: service_type;

  @ManyToMany(() => Vehicle, (vehicle) => vehicle.services, {
    onUpdate: 'CASCADE',
  })
  vehicles: Vehicle[];
}

enum service_type {
  overdue = 'overdue',
  upcoming = 'upcoming',
}
