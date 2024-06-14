import { LightningElement } from 'lwc';
import getFilteredArticles from '@salesforce/apex/HTTPRequestController.parseArticles';


export default class FilterArticlesAPPIAN extends LightningElement {
    
    filters = [{ }];
    selectedColumns = [];
    filteredArticles = [];

    columnOptions = [
        { label: 'Title', value: 'title' },
        { label: 'Description', value: 'description' },
        { label: 'Modified', value: 'modified'},
        { label: 'Access Level', value: 'accessLevel'},
        { label: 'Identifier', value: 'identifier'},
        { label: 'Landing Page', value: 'landingPage' },
        { label: 'License', value: 'license'},
        { label: 'Rights', value: 'rights'},
        { label: 'Spatial', value: 'spatial'},
        { label: 'Temporal', value: 'temporal'},
        { label: 'Accrual Periodicity', value: 'accrualPeriodicity'},
    ];

    propertyOptions = [
        { label: 'Title', value: 'title' },
        { label: 'Keyword', value: 'keyword' },
        { label: 'Theme', value: 'theme' },
        { label: 'Bureau Code', value: 'bureauCode' },
        { label: 'Program Code', value: 'programCode' }
    ];

    tableColumns = [];
    pageNumber = 1;
    pageSize = 50;
    sortedBy;
    sortedDirection;
    totalRecords;
    isFirstPage = true;
    isLastPage = false;
    objectSelected = false; 
    nextId = 1;


    handleChange(event) {
        this.objectSelected = true;
        this.selectedColumns = event.detail.value;
        this.updateTableColumns();
    }

    handleFilterPropertyChange(event) {
        const filterId = event.target.dataset.id;
        const property = event.detail.value;
        this.updateFilter(filterId, 'property', property);
    }

    handleFilterValueChange(event) {
        const filterId = event.target.dataset.id;
        const value = event.detail.value;
        this.updateFilter(filterId, 'value', value);
    }

    updateFilter(filterId, field, value) {
        this.filters = this.filters.map(filter => {
            if (filter.id == filterId) {
                return { ...filter, [field]: value };
            }
            return filter;
        });
    }

    handleAddFilter() {
        this.filters = [...this.filters, { id: this.nextId++, property: '', value: '' }];
    }

    // Handle deleting a filter
    handleDeleteFilter(event) {
        const filterId = event.target.dataset.id;
        this.filters = this.filters.filter(f => f.id != filterId);
    }

    handleSearch() {
        const titleFilters = this.filters.filter(f => f.property == 'title').map(f => f.value);
        const keywordFilters = this.filters.filter(f => f.property == 'keyword').map(f => f.value);
        const themeFilters = this.filters.filter(f => f.property == 'theme').map(f => f.value);
        const bureauCodeFilters = this.filters.filter(f => f.property == 'bureauCode').map(f => f.value);
        const programCodeFilters = this.filters.filter(f => f.property == 'programCode').map(f => f.value);

        getFilteredArticles({ titleFilters, keywordFilters, themeFilters, bureauCodeFilters, programCodeFilters })
            .then(data => {

                const articles = JSON.parse(data);
                this.filteredArticles = articles.slice(0, this.pageSize);
                this.totalRecords = data.length;
                this.pageNumber = 1;
                this.updatePagination();
                
            })
            .catch(error => {
                console.error(error);
            });
    }

    handlePrevious() {
        if (this.pageNumber > 1) {
            this.pageNumber--;
            this.updatePagination();
        }
    }

    handleNext() {
        if (this.pageNumber < Math.ceil(this.totalRecords / this.pageSize)) {
            this.pageNumber++;
            this.updatePagination();
        }
    }

    updatePagination() {
        this.isFirstPage = this.pageNumber === 1;
        this.isLastPage = this.pageNumber === Math.ceil(this.totalRecords / this.pageSize);
        const start = (this.pageNumber - 1) * this.pageSize;
        const end = this.pageNumber * this.pageSize;
        this.filteredArticles = this.filteredArticles.slice(start, end);
    }

    updateTableColumns() {
        this.tableColumns = this.selectedColumns.map(col => ({
            label: col.charAt(0).toUpperCase() + col.slice(1),
            fieldName: col,
            sortable: true
        }));
    }

}