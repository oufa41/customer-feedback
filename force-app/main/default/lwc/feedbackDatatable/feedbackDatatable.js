/**
 * @description       : 
 * @author            : Ahmed Abdelraouf
 * @group             : 
 * @last modified on  : 08-02-2024
 * @last modified by  : Ahmed Abdelraouf
**/
import { LightningElement, track } from 'lwc';

import getFeedback from '@salesforce/apex/FeedbackDatatableController.getFeedback';

const columns = [
    { label: 'Customer Name', fieldName: 'customerName', sortable: true },
    { label: 'Email', fieldName: 'customerEmail', sortable: true },
    { label: 'Feedback', fieldName: 'feedbackText' },
    { label: 'Date Submitted', fieldName: 'dateSubmitted', type: 'date', sortable: true },
    { label: 'Status', fieldName: 'status', sortable: true }
];


export default class FeedbackDatatable extends LightningElement {
    @track feedbacks;
    @track error;
    @track statusFilter = '';
    @track sortedBy;
    @track sortedDirection = 'asc';
    rowOffset = 0;
    @track isLoading = false;
    @track offset = 0;
    @track limit = 5;
    @track totalRecords = 0;

    columns = columns;
    statusOptions = [
        { label: 'All', value: '' },
        { label: 'New', value: 'New' },
        { label: 'Reviewed', value: 'Reviewed' },
        { label: 'Overdue', value: 'Overdue' }
    ];

    handleLoadMore() {
        if (!this.isLoading) {
            this.loadFeedbacks();
        }
    }
    connectedCallback() {
        this.loadFeedbacks();
    }
    loadFeedbacks() {
        console.log('offset: ' + this.offset);
        console.log('totalRecords: ' + this.totalRecords);

        if (this.offset > this.totalRecords) {
            this.isLoading = false;
            return;
        }
        this.isLoading = true;

        getFeedback({ statusFilter: this.statusFilter, offset: this.offset, limitNo: this.limit })
            .then(result => {
                this.feedbacks = [...this.feedbacks, ...result.feedbacks];
                this.totalRecords = result.totalRecords;

                this.isLoading = false;
                this.offset += this.limit;
            })
            .catch(error => {
                this.isLoading = false;
                this.error = error;
                console.log(">>>>>>>>>>>>>>>>");

                console.log([error]);

                console.error(error);
            });
    }

    // @wire(getFeedback, { statusFilter: '$statusFilter' })
    // wiredFeedbacks({ error, data }) {
    //     console.log('data: ' + data);

    //     if (data) {
    //         this.feedbacks = data;
    //         console.log('feedbacks: ' + this.feedbacks);
    //         console.log('feedbacks: ' + this.feedbacks.length);

    //         this.error = undefined;
    //     } else if (error) {
    //         this.error = error;
    //         this.feedbacks = undefined;
    //     }
    //     console.log('error:' + this.error);
    // }

    handleStatusFilterChange(event) {
        this.statusFilter = event.detail.value;
        this.resetData();
        this.loadFeedbacks();

    }

    handleSort(event) {
        const { fieldName: sortedBy, sortDirection: direction } = event.detail;
        this.sortedBy = sortedBy;
        this.sortedDirection = direction;
        this.sortData(sortedBy, direction);
    }

    sortData(fieldName, direction) {
        let parseData = JSON.parse(JSON.stringify(this.feedbacks));
        let keyValue = (a) => {
            return a[fieldName];
        };
        let isReverse = direction === 'asc' ? 1 : -1;
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : '';
            y = keyValue(y) ? keyValue(y) : '';
            return isReverse * ((x > y) - (y > x));
        });
        this.feedbacks = parseData;
    }
    resetData() {
        this.feedbacks = [];
        this.offset = 0;
        this.totalRecords = 0;

        this.error = null;
    }
    get hasRecords() {
        return this.feedbacks && this.feedbacks.length > 0;
    }
    get noRecordsMessage() {
        console.log('>>>>>>>>>>>>>>>>>>>>');

        console.debug(this.statusFilter);
        // return this.feedbacks && this.feedbacks.length > 0 ? '' : '' + this.statusFilter;
        if (this.error) {
            return `Error loading feedback records: ${this.error}`;
        }
        if (!this.hasRecords) {
            return `No feedback records found${this.statusFilter ? ` for status: ${this.statusFilter}` : ''}`;
        }
        return '';
    }
} 