import { Component, Input, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { AuthService } from '@auth0/auth0-angular';
import { take } from 'rxjs';
import { Client } from 'src/app/models/client.model';
import { ClientService } from 'src/app/services/client.service';

@Component({
  selector: 'app-profile-content',
  templateUrl: './profile-content.component.html',
  styleUrls: ['./profile-content.component.css'],
})
export class ProfileContentComponent implements OnInit, OnChanges {
  @Input() client: Client;
  clientForm: FormGroup;

  constructor(public auth: AuthService, private clientService: ClientService) {}

  ngOnInit(): void {
    this.clientForm = new FormGroup({
      'firstName': new FormControl(null),
      'lastName': new FormControl(null),
      'phoneNumber': new FormControl(null)
    })

  }

  // Wait for @Input() to change then load
  ngOnChanges(): void {
    if (this.client) {
      this.clientForm.patchValue({
        'firstName': this.client.firstName,
        'lastName': this.client.lastName,
        'phoneNumber': this.client.phoneNumber
      })
    }
  }

  onSave() {
    this.client.firstName = this.clientForm.get('firstName').value;
    this.client.lastName = this.clientForm.get('lastName').value;
    this.client.phoneNumber = this.clientForm.get('phoneNumber').value;

    this.clientService.updateClient(this.client).subscribe();
  }
}
